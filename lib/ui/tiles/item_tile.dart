import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_bool.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_items.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/item_detail_screen.dart';
import 'package:gatherthem_mobile_app/utils.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  final BlocItems blocItem;
  final CollectionModel collection;
  final BlocBool isEditionBloc = BlocBool(initValue: false);

  ItemTile({Key? key,
    required this.item,
    required this.blocItem,
    required this.collection})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isEditionBloc.stream,
        initialData: false,
        builder: (context, snapshot) {
          var isEditionMode = snapshot.data ?? false;
          if (isEditionMode) {
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
                    child: tileBody(context, item, isEditionMode, isEditionBloc),
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
                                    item: item, collection: collection)));
                          },
                          mini: true,
                          backgroundColor: Colors.orangeAccent,
                          child: const Icon(Icons.edit_outlined),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        FloatingActionButton(
                            heroTag: 'delete ${item.id}',
                            onPressed: () async {
                              bool res = await ItemService().deleteItem(item.id, context);
                              if(res){
                                blocItem.fetchItems(collection.id, context);
                              }
                            },
                            mini: true,
                            backgroundColor: Colors.redAccent,
                            child: const Icon(Icons.delete_outline_rounded)
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        IconButton(
                            onPressed: () {isEditionBloc.setBool(false);},
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
            return tileBody(context, item, isEditionMode, isEditionBloc);
          }

        }
    );
  }

  Widget tileBody(BuildContext context, ItemModel item, bool isEditionMode, BlocBool isEditionBloc){
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
                    collectionItem: item, collection: collection,
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
                visible: !isEditionMode,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () => isEditionBloc.setBool(!isEditionMode),
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Theme.of(context).backgroundColor,
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
