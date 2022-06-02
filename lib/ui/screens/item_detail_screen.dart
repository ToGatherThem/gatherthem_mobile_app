import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_item.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/models/item_property_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/tiles/item_property_tile.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/select_image_modal.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:gatherthem_mobile_app/utils.dart';

class ItemDetailScreen extends StatelessWidget {
  final String collectionId;
  final ItemModel collectionItem;

  const ItemDetailScreen({Key? key, required this.collectionItem, required this.collectionId})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.w800);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    Widget body = bodyConfig(context, titleStyle, descriptionStyle);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  StreamBuilder<ItemModel> bodyConfig(
      BuildContext context, TextStyle titleStyle, TextStyle descriptionStyle) {
    BlocItem blocSingleItem = BlocItem();
    ItemModel item;
    SelectImageModal selectImageModal = SelectImageModal();
    TextStyle labelStyle =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    TextStyle valueStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
    return StreamBuilder<ItemModel>(
      stream: blocSingleItem.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          item = snapshot.data!;
        }
        else{
          item = collectionItem;
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => selectImageModal.show(context),
                              child: Container(
                                  height: 115,
                                  width: 115,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1
                                      )
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Stack(
                                          children: [
                                            Container(
                                              color: Colors.grey,
                                            ),
                                            const Center(
                                              child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                                            )
                                          ]
                                      )
                                  )
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 65,
                                        child: Text(
                                            item.label,
                                            overflow: TextOverflow.ellipsis,
                                            style: titleStyle
                                        )
                                    ),
                                    Text(
                                        Strings.obtentionLabel,
                                        style: labelStyle
                                    ),
                                    Text(
                                      Utils.convertUTCToLocalString(item.obtentionDate),
                                      style: valueStyle,
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      for (ItemPropertyModel property in item.properties)
                        ItemPropertyTile(
                            itemProperty: property,
                            labelStyle: labelStyle,
                            valueStyle: valueStyle
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                            child: Card(
                                elevation: 0,
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit),
                                        Padding(padding: EdgeInsets.all(10)),
                                        Text("Modifier"),
                                      ],
                                    ))),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditItemScreen(
                                        item: item,
                                        collectionId: collectionId,
                                        blocSingleItem: blocSingleItem,
                                      )));
                            }),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                                child: Card(
                                    elevation: 0,
                                    child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.delete,
                                            ),
                                            Padding(padding: EdgeInsets.all(10)),
                                            Text("Supprimer"),
                                          ],
                                        ))),
                                onTap : () async {
                                  bool res = await ItemService().deleteItem(item.id);
                                  if (res) {
                                    blocItems.fetchItems(collectionId);
                                    Navigator.pop(context);
                                  }
                                }))),
                  ],
                )
              ],
            ),
          ),
        );




        /*return Scaffold(
          body: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.photo_album_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.label, style: titleStyle),
                                  // TODO need to be add with template
                                  *//*Text(
                                    collection.type,
                                    style: subtitleStyle
                                ),*//*
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Text("Id : " + item.id,
                                    style: descriptionStyle),
                                Text(
                                    "Date : " +
                                        Utils.convertUTCToLocalString(item.obtentionDate),
                                    style: descriptionStyle)
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                          child: Card(
                              elevation: 0,
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit),
                                      Padding(padding: EdgeInsets.all(10)),
                                      Text("Modifier"),
                                    ],
                                  ))),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditItemScreen(
                                      item: item,
                                      collectionId: collectionId,
                                      blocSingleItem: blocSingleItem,
                                    )));
                          }),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                              child: Card(
                                  elevation: 0,
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.delete,
                                          ),
                                          Padding(padding: EdgeInsets.all(10)),
                                          Text("Supprimer"),
                                        ],
                                      ))),
                              onTap : () async {
                                bool res = await ItemService().deleteItem(item.id);
                                if (res) {
                                  blocItems.fetchItems(collectionId);
                                  Navigator.pop(context);
                                }
                              }))),
                ],
              )
            ],
          ),
        );*/
      }
    );
  }
}


