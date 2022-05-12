import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_bool.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';


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
        return Stack(
          children: [
            Padding(
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
                                collection.template?.fullName ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16, color: Theme
                                    .of(context)
                                    .primaryColor
                                ),
                              ),
                              Text(
                                collection.name,
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
            Visibility(
              visible: snapshot.data ?? false,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Visibility(
              visible: snapshot.data ?? false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton(
                            onPressed: () {},
                            mini: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                        ),
                        FloatingActionButton(
                            onPressed: () async {
                              bool res = await CollectionService().deleteCollection(collection.id);
                              if(res){
                                blocCollection.fetchCollections();
                              }
                            },
                            mini: true,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.delete)
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
            ),
          ],
        );
      }
    );
  }
}


/*
SlidableAction(
onPressed: (context) async {
bool res = await CollectionService().deleteCollection(collection.id);
if(res){
blocCollection.fetchCollections();
}
},
onPressed: (context) async{
Navigator.push(context, MaterialPageRoute(
builder: (context) =>  EditCollectionScreen(
collection: collection)));
},
*/