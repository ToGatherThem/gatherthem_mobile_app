import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';

class TemplatePropertyTile extends StatelessWidget{
  final PropertyModel property;

  const TemplatePropertyTile({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Text(property.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(property.type, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}