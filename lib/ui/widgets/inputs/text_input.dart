import 'dart:ui';

import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        cursorColor: Colors.black,
        style: const TextStyle(
            color: Colors.black
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          focusColor: Colors.transparent,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: const Color(0xFFD6D6D6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 5)
      ),
    );
  }
}