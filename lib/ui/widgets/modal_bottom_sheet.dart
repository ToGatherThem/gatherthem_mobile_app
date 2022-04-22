import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_items.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_item_screen.dart';

class ModalBottomSheet extends StatelessWidget {
  final CollectionModel? currentCollection;
  final BlocItems? currentBlocItem;
  const ModalBottomSheet({Key? key, this.currentCollection, this.currentBlocItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (currentCollection != null && currentCollection!.id != "") ? 150 : 100,
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
              child: const Text(Strings.createColl),
              style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCollectionScreen())
                );
              },
            ),
          ),
          Visibility(
            visible: currentCollection != null && currentBlocItem != null && currentCollection!.id != "",
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                child: const Text(Strings.createCollItem),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItemScreen(collection: currentCollection!, blocItem: currentBlocItem!))
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