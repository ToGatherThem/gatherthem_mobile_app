import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/item_property_model.dart';
import 'package:gatherthem_mobile_app/utils.dart';

/// Class that represents a property of an item, usually used in a list of properties
class ItemPropertyTile extends StatelessWidget{

  final ItemPropertyModel itemProperty;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  const ItemPropertyTile({Key? key, required this.itemProperty,  required this.labelStyle, required this.valueStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String value = itemProperty.value;
    if(itemProperty.property.type == 'DATE'){
      value = Utils.formatStringDate(value);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(itemProperty.property.name, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}