import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/lists/collections_list.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NavigationScaffoldWidget(body: CollectionsList());
  }
}
