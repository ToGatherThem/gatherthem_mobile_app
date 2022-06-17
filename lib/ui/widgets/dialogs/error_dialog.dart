import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';

/// Custom dialog used to display an error message
class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: [
        Center(
          child: TextButton(
              child: const Text(Strings.okLabel),
              onPressed: () { Navigator.of(context).pop(); }
          ),
        ),
      ],
    );
  }
}