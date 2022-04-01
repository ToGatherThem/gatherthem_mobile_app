import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_item_screen.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: currentCollection.id != "" ? 150 : 100,
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 25,
              child: IconButton(
                iconSize: 20,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              child: const Text("Ajouter une collection"),
              style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddCollectionScreen())
                );
              },
            ),
          ),
          Visibility(
            visible: currentCollection.id != "",
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                child: const Text("Ajouter un objet dans cette collection"),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItemScreen(collection: currentCollection))
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}