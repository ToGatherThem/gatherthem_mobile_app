import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_bool.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/edit_collection_screen.dart';


class CollectionTile extends StatelessWidget {
  final CollectionModel collection;

  CollectionTile({Key? key, required this.collection}) : super(key: key);

  final BlocBool isEdition = BlocBool(initValue: false);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isEdition.stream,
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return Stack(
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
                          const Icon(
                            Icons.photo,
                            size: 55,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  collection.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16, color: Theme
                                      .of(context)
                                      .primaryColor
                                  ),
                                ),
                                Text(
                                  collection.template.fullName,
                                  style: TextStyle(
                                      fontSize: 16, color: Theme
                                      .of(context)
                                      .primaryColor
                                  ),
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
                                  color: Theme.of(context).primaryColor,
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton(
                          heroTag: 'edit ${collection.id}',
                          onPressed: () async{
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  EditCollectionScreen(
                                    collection: collection)));
                          },
                          mini: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          backgroundColor: Colors.orange,
                          child: const Icon(Icons.edit_outlined),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        FloatingActionButton(
                            heroTag: 'delete ${collection.id}',
                            onPressed: () async {
                              bool res = await CollectionService().deleteCollection(collection.id);
                              if(res){
                                blocCollection.fetchCollections();
                              }
                            },
                            mini: true,
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.delete_outline_rounded)
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {isEdition.setBool(false);},
                        icon: Icon(
                            Icons.close,
                            color: Theme.of(context).primaryColor
                        )
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        else{
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        CollectionScreen(
                            collection: collection
                        )
                    ),
                  );
                },
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
                          children: [
                            Text(
                              collection.name,
                              style: getTextStyle(context, weight: FontWeight.bold, color: Theme.of(context).backgroundColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              collection.template.fullName,
                              style: getTextStyle(context, color: Theme.of(context).backgroundColor),
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
            ),
          );
        }

      }
    );
  }
}
