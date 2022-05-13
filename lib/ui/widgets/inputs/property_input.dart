import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';

class PropertyInput extends StatelessWidget{
  final PropertyModel property;

  const PropertyInput({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (property.type) {
      case "INTEGER": {
        return TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: property.name,
            icon: const Icon(Icons.numbers_rounded),
          )
        );
      }

      case "DATE": {
        return DateTimePicker(
          type: DateTimePickerType.date,
          dateMask: "d MMMM yyyy",
          locale: const Locale("fr", "FR"),
          firstDate: DateTime(1970),
          lastDate: DateTime.now(),
          timePickerEntryModeInput: true,
          decoration: InputDecoration(
            labelText: property.name,
            icon: const Icon(Icons.calendar_today),
          ),
        );
      }

      case "DURATION": {
        return TextField(
          keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: property.name,
              icon: const Icon(Icons.timer_rounded),
            )
        );
      }

      default: {
        return TextField(
          decoration: InputDecoration(
            labelText: property.name,
            icon: const Icon(Icons.text_fields),
          )
        );
      }
    }
  }
}