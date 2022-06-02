import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_recentsearches.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/search_results_screen.dart';

class RecentSearchTile extends StatelessWidget {
  final String searchText;
  final BlocRecentSearches bloc;
  const RecentSearchTile({Key? key, required this.searchText, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: const EdgeInsets.all(0),
      leading: const Icon(Icons.history),
      title: Text(searchText),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        splashRadius: 20,
        tooltip: Strings.searchRecentClear,
        onPressed: () {
          List<String> recentSearches = sharedPreferences.getStringList("recent_searches")!;
          recentSearches.remove(searchText);
          sharedPreferences.setStringList("recent_searches", recentSearches);
          bloc.fetchRecentSearches();
        },
      ),
      onTap: () {
        List<String> recentSearches = sharedPreferences.getStringList("recent_searches")!;
        recentSearches.remove(searchText);
        recentSearches.add(searchText);
        sharedPreferences.setStringList("recent_searches", recentSearches);
        bloc.fetchRecentSearches();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchResultsScreen(searchText: searchText)
        ));
      },
    );
  }
}