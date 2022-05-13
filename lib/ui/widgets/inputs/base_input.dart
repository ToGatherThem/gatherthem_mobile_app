import 'package:flutter/material.dart';

class BaseInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String? defaultValue;
  final IconData? icon;
  final void Function(String) onChanged;

  const BaseInput({Key? key, required this.label, required this.keyboardType, this.defaultValue, this.icon, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: keyboardType,
        initialValue: defaultValue,
        decoration: InputDecoration(
          labelText: label,
          icon: (icon != null) ? Icon(icon) : null,
        ),
        onChanged: onChanged,
    );
  }

}