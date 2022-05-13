import 'package:flutter/material.dart';

class BaseInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String? defaultValue;
  final IconData? icon;
  final bool obscureText;
  final void Function(String) onChanged;

  const BaseInput({Key? key, required this.label, required this.keyboardType, this.defaultValue, this.icon, this.obscureText = false, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      initialValue: defaultValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        icon: (icon != null) ? Icon(icon) : null,
      ),
      onChanged: onChanged,
    );
  }

}