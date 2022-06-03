import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/item_detail_screen.dart';
import 'package:gatherthem_mobile_app/utils.dart';

class SearchResultItemTile extends StatelessWidget {
  final ItemModel item;
  const SearchResultItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  ItemDetailScreen(
                    collectionItem: item,
                  )
              ),
            );
          },
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  size: 55,
                  color: Theme.of(context).backgroundColor,
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label,
                        style: Styles.getTextStyle(context, weight: FontWeight.bold, color: Theme.of(context).backgroundColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        Utils.convertUTCToLocalString(item.obtentionDate),
                        style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}