import 'package:flutter/material.dart';

import '../screens/add_collection_screen.dart';
import 'app_brand.dart';
import 'custom_navigation_bar.dart';

class NavigationScaffoldWidget extends StatelessWidget {
  final Widget body;

  const NavigationScaffoldWidget({Key? key, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const AppBrand(),
        automaticallyImplyLeading: false,
      ),
      body: body,
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddCollectionScreen()));
        },
        child: const Icon(Icons.add),
        elevation: 2,
        backgroundColor: Theme.of(context).focusColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
