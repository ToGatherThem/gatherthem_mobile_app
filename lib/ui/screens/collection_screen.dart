import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key, required this.collection}) : super(key: key);
  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    Widget body = bodyConfig(collection: collection, context: context);
    return NavigationScaffoldWidget(body: body);
  }

  Widget bodyConfig({required CollectionModel collection, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 0,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(collection.id.toString()),
              Text(collection.name),
              Text(collection.description),
              Text(collection.creationDate.toString()),

            ],
          ),
        ),
      ),
    );
  }
}
