import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_bool.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_item.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/item_detail_screen.dart';
import 'package:intl/intl.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  final BlocItem blocItem;
  final String collectionId;

  const ItemTile({Key? key, required this.item, required this.blocItem, required this.collectionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocBool longPress = BlocBool(initValue: false);
    bool initalValue = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () {
              initalValue = false;
              longPress.setBool(initalValue);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemDetailScreen(
                              collectionItem: item,
                              collectionId: collectionId,
                              blocItem: blocItem,
                          )));
            },
            onLongPress: () {
              initalValue = !initalValue;
              longPress.setBool(initalValue);
            },
            onDoubleTap: () {
              initalValue = !initalValue;
              longPress.setBool(initalValue);
            },
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(item.label.toString()),
                    Text(DateFormat(Strings.dayFormat)
                        .format(DateTime.parse(item.obtentionDate))
                        .toString()),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<bool>(
              stream: longPress.stream,
              initialData: false,
              builder: (context, snapshot) {
                return Visibility(
                  visible: snapshot.data != null && snapshot.data!,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FloatingActionButton(
                      mini: true,
                      elevation: 0,
                      hoverElevation: 0,
                      backgroundColor: Colors.transparent,
                      heroTag: 'editButton${item.id}',
                      child: const Icon(
                        Icons.edit,
                        color: Colors.orangeAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditItemScreen(
                                      itemId: item.id,
                                      blocItem: blocItem,
                                      collectionId: collectionId,
                                    )));
                      },
                    ),
                  ),
                );
              }),
          StreamBuilder<bool>(
              stream: longPress.stream,
              initialData: false,
              builder: (context, snapshot) {
                return Visibility(
                  visible: snapshot.data != null && snapshot.data!,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      mini: true,
                      elevation: 0,
                      hoverElevation: 0,
                      backgroundColor: Colors.transparent,
                      heroTag: 'deleteButton${item.id}',
                      child: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        ItemService().deleteItem(item.id);
                        blocItem.fetchItems(collectionId);
                      },
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
