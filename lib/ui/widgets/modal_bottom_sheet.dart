import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              child: const Text("Ajouter un objet"),
              style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: () {
                print("add item");
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const AddCollectionScreen())
                // );
              },
            ),
          )
        ],
      ),
    );
  }
}