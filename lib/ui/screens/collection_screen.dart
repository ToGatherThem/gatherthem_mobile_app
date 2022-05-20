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
        collection: collection,
        context: context,
        blocItem: blocItems);
    return NavigationScaffoldWidget(body: body, leading: true, collectionModel: collection);
  }

  Widget bodyConfig({required CollectionModel collection,
    required BuildContext context,
    required BlocItems blocItem}) {
    TextStyle titleStyle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    return Column(
          children: [
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  color: Theme
                      .of(context)
                      .backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.photo,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              size: 80,
                            ),
                          ),
                          Expanded(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(collection.name, style: titleStyle),
                                Text(
                                  collection.template.fullName,
                                  style: subtitleStyle
                                ),
                                Text(
                                    Utils.convertUTCToLocalString(collection.creationDate),
                                    style: subtitleStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.2,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              color: Theme
                                  .of(context)
                                  .bottomAppBarColor,
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Text(
                                  collection.description,
                                  style: descriptionStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<List<ItemModel>>(
                stream: blocItem.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(); //TODO loading
                  }
                  return Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      children: snapshot.data!.map((item) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ItemTile(
                              item: item,
                              blocItem: blocItem,
                              collectionId: collection.id,
                            ),
                        );

                      }).toList(),
                    ),
                  );
                })
          ],
        );
  }
}
