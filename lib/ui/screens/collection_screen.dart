import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/ui/widgets/custom_navigation_bar.dart';

import '../widgets/app_brand.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key, required this.collection}) : super(key: key);
  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const AppBrand(),
        automaticallyImplyLeading: true,
      ),
      body: bodyConfig(collection: collection, context: context),
      bottomSheet: const CustomNavigationBar(),
    );
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
              Text(collection.type),
              Text(collection.description),
              Text(collection.creationDate.toString()),

            ],
          ),
        ),
      ),
    );
  }
}
