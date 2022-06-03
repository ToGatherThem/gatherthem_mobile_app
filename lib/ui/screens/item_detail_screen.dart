import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_item.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/models/item_property_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/tiles/item_property_tile.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:gatherthem_mobile_app/utils.dart';

class ItemDetailScreen extends StatelessWidget {
  final CollectionModel? collection;
  final ItemModel collectionItem;

  const ItemDetailScreen({Key? key, required this.collectionItem, this.collection})
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
    TextStyle labelStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
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
        return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                                    child: (item.image == null) ? Stack(
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                          ),
                                          const Center(
                                            child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                                          )
                                        ]
                                    ) : Image(
                                      image: MemoryImage(item.image!),
                                      fit: BoxFit.cover,
                                    )
                                )
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
                    ActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditItemScreen(
                                  item: item,
                                  collection: collection!,
                                  blocSingleItem: blocSingleItem,
                                )));
                      },
                      text: Strings.editLabel,
                      backgroundColor: Colors.orangeAccent,
                      icon: Icons.edit,
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    const SizedBox(width: 10),
                    ActionButton(
                      onPressed: () async {
                        bool res = await ItemService().deleteItem(item.id, context);
                        if (res) {
                          blocItems.fetchItems(collection!.id, context);
                          Navigator.pop(context);
                        }
                      },
                      text: Strings.deleteLabel,
                      icon: Icons.delete,
                      backgroundColor: Colors.redAccent,
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
        );
      }
    );
  }
}


