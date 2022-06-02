import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_items.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/ui/tiles/item_tile.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

import '../../utils.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key, required this.collection})
      : super(key: key);
  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    blocItems = BlocItems();
    blocItems.fetchItems(collection.id);
    Widget body = bodyConfig(
        collection: collection, context: context, blocItem: blocItems);
    return NavigationScaffoldWidget(
        body: body, leading: true, collectionModel: collection);
  }

  Widget bodyConfig(
      {required CollectionModel collection,
      required BuildContext context,
      required BlocItems blocItem}) {
    TextStyle titleStyle =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.photo,
                        color: Theme.of(context).primaryColor,
                        size: 120,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(collection.name, style: titleStyle),
                          Text(collection.template.fullName,
                              style: subtitleStyle),
                          Text(
                              Utils.convertUTCToLocalString(
                                  collection.creationDate),
                              style: subtitleStyle),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Theme.of(context).backgroundColor,
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20),
                        child: Text(
                          collection.description,
                          style: descriptionStyle,

                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 10),
                  child:Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).cardColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: const TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'type the item name...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<List<ItemModel>>(
              stream: blocItem.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(); //TODO loading
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ItemTile(
                              item: item,
                              blocItem: blocItem,
                              collectionId: collection.id,
                            ),
                          ))
                      .toList(),
                );
              })
        ],
      ),
    );
  }
}
