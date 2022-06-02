  import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/ui/tiles/collection_tile.dart';

class CollectionsList extends StatelessWidget{
  const CollectionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    blocCollection.fetchCollections(context);
    return StreamBuilder<List<CollectionModel>>(
      stream: blocCollection.stream,
      builder: (context, snapshotCollections) {
        if(snapshotCollections.hasData){
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: snapshotCollections.data!.map((collection) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CollectionTile(collection: collection,),
                )
            ).toList(),
          );
        }
        else{
          return Container();
        }
      }
    );
  }

}