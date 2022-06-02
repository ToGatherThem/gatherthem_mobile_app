import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:gatherthem_mobile_app/ui/tiles/recentsearch_tile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocRecentSearches extends Bloc {
  final _streamController = BehaviorSubject<List<RecentSearchTile>>();

  Stream<List<RecentSearchTile>> get stream => _streamController.stream;

  Sink<List<RecentSearchTile>> get sink => _streamController.sink;

  fetchRecentSearches() async {
    var resultRequest = await SharedPreferences.getInstance();
    var recentSearches = resultRequest.getStringList("recent_searches");
    setRecentSearches(recentSearches!);
  }

  setRecentSearches(List<String> recentSearches) async {
    sink.add(recentSearches.reversed.map((searchText) => RecentSearchTile(searchText: searchText, bloc: this)).toList());
  }

  @override
  dispose() {
    _streamController.close();
  }
}