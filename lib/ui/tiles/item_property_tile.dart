import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/item_property_model.dart';

class ItemPropertyTile extends StatelessWidget{

  final ItemPropertyModel itemProperty;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  const ItemPropertyTile({Key? key, required this.itemProperty,  required this.labelStyle, required this.valueStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(itemProperty.property.type);
    String value = itemProperty.value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
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