  import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';

class CollectionsList extends StatelessWidget{
  const CollectionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> collections = [
      "Livres",
      "Timbres",
      "Agraffes",
      "Figurines",
      "Cannettes",
      "Jeux de sociétés",
      "Projets"
    ];

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: collections.map((title) =>
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: CollectionTile(title: title,),
        )
      ).toList(),
    );
  }

}