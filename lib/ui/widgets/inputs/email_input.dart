import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/base_input.dart';


/// Specialized input for email, implementation of our base input
class EmailInput extends StatelessWidget {
  final String label;
  final String? defaultValue;
  final IconData? icon;
  final void Function(String) onChanged;
  final Iterable<String>? autofillHints;

  const EmailInput({Key? key, required this.label, this.defaultValue, this.icon, required this.onChanged, this.autofillHints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
        label: label,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        icon: icon,
        defaultValue: defaultValue,
        autofillHints: autofillHints
    );
  }
}