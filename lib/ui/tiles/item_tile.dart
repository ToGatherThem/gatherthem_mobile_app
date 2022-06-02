import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_bool.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_items.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/item_detail_screen.dart';
import 'package:gatherthem_mobile_app/utils.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  final BlocItems blocItem;
  final String collectionId;
  final BlocBool isEdition = BlocBool(initValue: false);

  ItemTile({Key? key,
    required this.item,
    required this.blocItem,
    required this.collectionId})
      : super(key: key);



  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isEdition.stream,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SizedBox(
              height: 95,
              child: Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 1,
                        sigmaY: 1,
                        tileMode: TileMode.decal
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                size: 55,
                                color: Theme.of(context).backgroundColor,
                              ),
                              const Padding(padding: EdgeInsets.only(left: 20)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.label,
                                      style: Styles.getTextStyle(context, weight: FontWeight.bold, color: Theme.of(context).backgroundColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.obtentionDate,
                                      style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'edit ${item.id}',
                          onPressed: () async{
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  EditItemScreen(
                                    item: item, collectionId: item.id,)));
                          },
                          mini: true,
                          backgroundColor: Colors.orangeAccent,
                          child: const Icon(Icons.edit_outlined),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        FloatingActionButton(
                            heroTag: 'delete ${item.id}',
                            onPressed: () async {
                              bool res = await CollectionService().deleteCollection(item.id);
                              if(res){
                                blocItem.fetchItems(item.id);
                              }
                            },
                            mini: true,
                            backgroundColor: Colors.redAccent,
                            child: const Icon(Icons.delete_outline_rounded)
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        IconButton(
                            onPressed: () {isEdition.setBool(false);},
                            icon: Icon(
                                Icons.close,
                                color: Theme.of(context).backgroundColor
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            );
          }
          else{
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ItemDetailScreen(
                              collectionItem: item, collectionId: collectionId,
                          )
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: (item.image == null) ?
                        Container(
                          color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Icon(
                              Icons.photo,
                              size: 55,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ) : Image(
                          image: MemoryImage(item.image!),
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.label,
                              style: Styles.getTextStyle(context, weight: FontWeight.bold, color: Theme.of(context).backgroundColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              Utils.convertUTCToLocalString(item.obtentionDate),
                              style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: snapshot.data != null && !snapshot.data!,
                        child: IconButton(
                            onPressed: () => isEdition.setBool(snapshot.data != null && !snapshot.data!),
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: Theme.of(context).backgroundColor,
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

        }
    );
  }
}
