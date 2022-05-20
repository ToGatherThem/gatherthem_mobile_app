import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/base_input.dart';

class EmailInput extends StatelessWidget {
  final String label;
  final String? defaultValue;
  final IconData? icon;
  final void Function(String) onChanged;

  const EmailInput({Key? key, required this.label, this.defaultValue, this.icon, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
        label: label,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        icon: icon,
        defaultValue: defaultValue,
    );
  }
}