import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/base_input.dart';

/// Specialized input for password, implementation of our base input
class PasswordInput extends StatelessWidget {
  final String label;
  final String? defaultValue;
  final IconData? icon;
  final void Function(String) onChanged;

  const PasswordInput({Key? key, required this.label, this.defaultValue, this.icon, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
        label: label,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        icon: icon,
        defaultValue: defaultValue,
        obscureText: true,
    );
  }
}