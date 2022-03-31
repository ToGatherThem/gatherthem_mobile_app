import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/app_brand.dart';
import 'package:gatherthem_mobile_app/ui/widgets/custom_navigation_bar.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modal_bottom_sheet.dart';

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
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const ModalBottomSheet();
              }
          );
        },
        child: const Icon(Icons.add),
        elevation: 2,
        backgroundColor: Theme.of(context).focusColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
