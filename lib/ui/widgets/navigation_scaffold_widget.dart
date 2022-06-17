import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/app_brand.dart';
import 'package:gatherthem_mobile_app/ui/widgets/custom_navigation_bar.dart';


/// Class used as the skeleton of our pages, it contains the basic scaffold, navigation bar and bottom bar and also the floating action button
class NavigationScaffoldWidget extends StatelessWidget {
  final Widget body;
  final bool leading;
  final CollectionModel? collectionModel;
  final Widget? trailingWidget;

  const NavigationScaffoldWidget({Key? key, required this.body, this.leading = false, this.collectionModel, this.trailingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: AppBrand(trailingWidget: trailingWidget),
        automaticallyImplyLeading: leading,
      ),
      body: body,
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: Visibility(
        visible: collectionModel != null && collectionModel!.id != "",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemScreen(collection: collectionModel!))
            );
          },
          child: const Icon(Icons.add),
          elevation: 2,
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).highlightColor,
          tooltip: Strings.itemAdd,
        ),
      ),
    );
  }
}
