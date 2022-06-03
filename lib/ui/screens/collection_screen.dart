import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_items.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
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
    blocItems.fetchItems(collection.id, context);
    Widget body = bodyConfig(
        collection: collection, context: context, blocItem: blocItems);
    return NavigationScaffoldWidget(
        body: body, leading: true, collectionModel: collection);
  }

  Widget bodyConfig(
      {required CollectionModel collection,
      required BuildContext context,
      required BlocItems blocItem}) {
    TextEditingController controller = TextEditingController();

    TextStyle titleStyle =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: (collection.image == null) ? Stack(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                  ),
                                  const Center(
                                    child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                                  )
                                ]
                            ) : Image(
                              image: MemoryImage(collection.image!),
                              fit: BoxFit.cover,
                            )
                        )
                    ),
                    const SizedBox(width: 20),
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
                const Padding(padding: EdgeInsets.only(top: 15)),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20),
                  child: Text(
                    collection.description,
                    style: descriptionStyle,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).cardColor),
                      borderRadius: BorderRadius.circular(20)),
                  child:  TextFormField(
                    controller: controller,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
                        splashRadius: 20,
                        tooltip: Strings.searchClear,
                        onPressed: () {
                          controller.clear();
                          blocItems.filter("");
                        },
                      ),
                      labelText: Strings.searchLabel,
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      blocItems.filter(value);
                    },
                  ),
                  ),

                const Padding(padding: EdgeInsets.only(top: 15)),
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
