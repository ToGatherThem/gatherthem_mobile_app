import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_item.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_items.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  final BlocItems blocItems;
  final String collectionId;
  final ItemModel collectionItem;

  const ItemDetailScreen({Key? key, required this.collectionItem, required this.blocItems, required this.collectionId})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    Widget body = bodyConfig(context, titleStyle, descriptionStyle);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  StreamBuilder<ItemModel> bodyConfig(
      BuildContext context, TextStyle titleStyle, TextStyle descriptionStyle) {
    BlocItem blocSingleItem = BlocItem();
    ItemModel item;
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
                                  /*Text(
                                    collection.type,
                                    style: subtitleStyle
                                ),*/
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
                                        DateFormat(Strings.dayFormat)
                                            .format(DateTime.parse(
                                              item.obtentionDate))
                                            .toString(),
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
                                  padding: EdgeInsets.all(20),
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
                                      itemId: item.id,
                                      collectionId: collectionId,
                                      blocItems: blocItems,
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
                                      padding: EdgeInsets.all(20),
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
        );
      }
    );
  }
}
