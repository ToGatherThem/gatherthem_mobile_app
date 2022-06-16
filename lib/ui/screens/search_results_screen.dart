import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/lists/search_results_collections_list.dart';
import 'package:gatherthem_mobile_app/ui/lists/search_results_items_list.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class SearchResultsScreen extends StatelessWidget {
  final String searchText;
  const SearchResultsScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = bodyConfig(context);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  Widget bodyConfig(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: Styles.getTextStyle(context, weight: FontWeight.bold),
          unselectedLabelStyle: Styles.getTextStyle(context),
          tabs: const [
            /*Chaque tab correspond à un onglet, à une catégorie de la recherche*/
            Tab(
              text: Strings.searchResultsCollections,
              icon: Icon(Icons.collections),
            ),
            Tab(
              text: Strings.searchResultsItems,
              icon: Icon(Icons.list),
            ),
            Tab(
              text: Strings.searchResultsUsers,
              icon: Icon(Icons.people),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SearchResultsCollectionsList(
                searchText: searchText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SearchResultsItemsList(
                searchText: searchText,
              ),
            ),
            const Center(child: Text(Strings.searchResultsNoResults)),
          ]
        ),
      ),
    );
  }
}