import 'package:flutter/cupertino.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_public_collections.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/tiles/search_result_collection_tile.dart';

class SearchResultsCollectionsList extends StatelessWidget {
  final String searchText;
  const SearchResultsCollectionsList({Key? key, required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocPublicCollections collections = BlocPublicCollections();
    collections.fetchCollections();
    return StreamBuilder<List<CollectionModel>>(
      stream: collections.stream,
      builder: (context, snapshotCollections) {
        if (snapshotCollections.hasData) {
          List filteredCollections = snapshotCollections.data!
              .where((collection) => matchesSearch(collection))
              .toList();
          if (filteredCollections.isNotEmpty) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: filteredCollections.map((collection) =>
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SearchResultCollectionTile(collection: collection),
                  )
              ).toList(),
            );
          } else {
            return const Center(child: Text(Strings.searchResultsNoResults));
          }
        }
        else{
          return Container();
        }
      }
    );
  }

  bool matchesSearch(CollectionModel collection) {
    return collection.name.toLowerCase().contains(searchText.toLowerCase())
        || collection.description.toLowerCase().contains(searchText.toLowerCase())
        || collection.template.name.toLowerCase().contains(searchText.toLowerCase());
  }
}