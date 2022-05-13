import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';

import 'date_input.dart';
import 'number_input.dart';

class PropertyInput extends StatelessWidget{
  final PropertyModel property;
  final void Function(String value) onChanged;

  const PropertyInput({Key? key, required this.property, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (property.type) {
      case "INTEGER": {
        return NumberInput(
          label: property.name,
          icon: Icons.numbers_rounded,
          onChanged: onChanged,
        );
      }

      case "DATE": {
        return DateInput(
          label: property.name,
          icon: Icons.calendar_today,
          firstDate: DateTime(0),
          lastDate: DateTime.now().add(const Duration(days: 365*10)),
          onChanged: onChanged
        );
      }

      case "DURATION": {
        return NumberInput(
          label: property.name,
          icon: Icons.timer_rounded,
          onChanged: onChanged,
        );
      }

      default: {
        return TextInput(
          label: property.name,
          icon: Icons.text_fields,
          onChanged: onChanged,
        );
      }
    }
  }
}