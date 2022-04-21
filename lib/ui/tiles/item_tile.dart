import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_item_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:intl/intl.dart';

class ItemTile extends StatelessWidget {
  final CollectionItemModel item;

  const ItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item.label.toString()),
              Text(DateFormat(Strings.dayFormat)
                  .format(DateTime.parse(item.obtentionDate))
                  .toString()),
            ],
          ),
        ),
      ),
    );
  }
}
