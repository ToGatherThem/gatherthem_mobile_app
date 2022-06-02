import 'package:flutter/cupertino.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_public_items.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/tiles/search_result_item_tile.dart';

class SearchResultsItemsList extends StatelessWidget {
  final String searchText;
  const SearchResultsItemsList({Key? key, required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocPublicItems items = BlocPublicItems();
    items.fetchItems(context);
    return StreamBuilder<List<ItemModel>>(
        stream: items.stream,
        builder: (context, snapshotCollections) {
          if (snapshotCollections.hasData) {
            List filteredItems = snapshotCollections.data!
                .where((item) => matchesSearch(item))
                .toList();
            if (filteredItems.isNotEmpty) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: filteredItems.map((item) =>
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SearchResultItemTile(item: item),
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

  bool matchesSearch(ItemModel item) {
    return item.label.toLowerCase().contains(searchText.toLowerCase());
  }
}