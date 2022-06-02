import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/base_input.dart';

class AutoCompleteInput extends StatelessWidget {

  final FocusNode focusNode;
  final TextEditingController controller;
  final String label;

  const AutoCompleteInput({Key? key, required this.focusNode, required this.controller, required this.label}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BaseInput(
        label: label,
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        controller: controller,
        onChanged: (value) => {},
    );
  }
}