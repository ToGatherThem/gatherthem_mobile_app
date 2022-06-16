import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_item_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/app_brand.dart';
import 'package:gatherthem_mobile_app/ui/widgets/custom_navigation_bar.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/add_collection_or_template_modal.dart';

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
      floatingActionButton: getContextFab(context)
    );
  }

  FloatingActionButton? getContextFab(BuildContext context) {
    bool isHomeScreen = context.findAncestorWidgetOfExactType<HomeScreen>() != null;
    bool canCreateItem = collectionModel != null && collectionModel!.id != "";
    if(canCreateItem|| isHomeScreen) {
      return FloatingActionButton(
        onPressed: () {
          if(canCreateItem) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemScreen(collection: collectionModel!))
            );
          } else if(isHomeScreen) {
            AddCollectionOrTemplateModal.show(context: context);
          }
        },
        child: const Icon(Icons.add),
        elevation: 2,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).highlightColor,
        tooltip: Strings.itemAdd,
      );
    } else {
      return null;
    }
  }
}
