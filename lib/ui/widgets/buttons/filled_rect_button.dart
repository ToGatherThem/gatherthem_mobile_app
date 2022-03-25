import 'package:flutter/material.dart';

class FilledRectButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  const FilledRectButton({Key? key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          primary: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).cardColor,
          textStyle: const TextStyle(fontSize: 15)
        ),
        child: Text(text!),
        onPressed: onPressed,
      ),
    );
  }
}