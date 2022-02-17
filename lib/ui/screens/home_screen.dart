import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/app_brand.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const AppBrand(),
      ),
    );
  }

}