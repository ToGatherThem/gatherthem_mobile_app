import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/lists/collections_list.dart';
import 'package:gatherthem_mobile_app/ui/widgets/app_brand.dart';
import 'package:gatherthem_mobile_app/ui/widgets/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const AppBrand(),
        automaticallyImplyLeading: false,
      ),
      body: const CollectionsList(),
      bottomSheet: const CustomNavigationBar(),
    );
  }

}