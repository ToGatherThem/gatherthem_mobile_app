import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_recentsearches.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/search_results_screen.dart';
import 'package:gatherthem_mobile_app/ui/tiles/recentsearch_tile.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocRecentSearches blocRecentSearches = BlocRecentSearches();
    blocRecentSearches.fetchRecentSearches();
    Widget body = bodyConfig(context, blocRecentSearches);
    return NavigationScaffoldWidget(body: body);
  }

  Widget bodyConfig(BuildContext context, BlocRecentSearches blocRecentSearches) {
    TextEditingController controller = TextEditingController();
    int maxResultsShown = 10;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
                      splashRadius: 20,
                      tooltip: Strings.searchClear,
                      onPressed: () {
                        controller.clear();
                      },
                    ),
                    labelText: Strings.searchLabel,
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    search(context, value, blocRecentSearches);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(Strings.searchRecent,
                  style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<RecentSearchTile>>(
              stream: blocRecentSearches.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: min(snapshot.data!.length, maxResultsShown),
                    itemBuilder: (context, index) {
                      return snapshot.data![index];
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]
      ),
    );
  }

  void search(BuildContext context, String searchText, BlocRecentSearches blocRecentSearches) {
    if (searchText.trim().isNotEmpty) {
      List<String> recentSearches = sharedPreferences.getStringList("recent_searches")!;
      if (recentSearches.contains(searchText)) {
        recentSearches.remove(searchText);
      }
      recentSearches.add(searchText);
      sharedPreferences.setStringList("recent_searches", recentSearches);
      blocRecentSearches.fetchRecentSearches();

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SearchResultsScreen(searchText: searchText)
      ));
    }
  }
}