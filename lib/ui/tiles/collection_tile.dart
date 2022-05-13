import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/custom_colors.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';

import '../screens/edit_collection_screen.dart';

class CollectionTile extends StatelessWidget {
  final CollectionModel collection;

  const CollectionTile({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                bool res = await CollectionService().deleteCollection(collection.id);
                if(res){
                  blocCollection.fetchCollections();
                }
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: CustomColors.lightFont,
              label: Strings.deleteLabel,
              icon: Icons.delete,
            ),
            SlidableAction(
              onPressed: (context) async{
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  EditCollectionScreen(
                        collection: collection)));
              },
              backgroundColor: Colors.orangeAccent,
              foregroundColor: CustomColors.lightFont,
              label: Strings.editLabel,
              icon: Icons.edit,
            ),
          ]
      ),
      endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
                onPressed: (context) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>  EditCollectionScreen(
                          collection: collection)));
                },
              backgroundColor: Colors.orangeAccent,
              foregroundColor: CustomColors.lightFont,
              label: Strings.editLabel,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) async {
                bool res = await CollectionService().deleteCollection(collection.id);
                if(res){
                  blocCollection.fetchCollections();
                }
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: CustomColors.lightFont,
              label: Strings.deleteLabel,
              icon: Icons.delete,
            ),
          ]
      ),
      child: Container(
        color: Theme.of(context).cardColor,
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
            const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
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
                        collection.template.fullName,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}