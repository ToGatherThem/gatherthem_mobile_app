import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';

class TextInput extends StatelessWidget {
  final String? credential;
  final bool obscureText;
  const TextInput({Key? key, this.credential, this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        initialValue: credentials[credential],
        obscureText: obscureText,
        cursorColor: Colors.black,
        style: const TextStyle(
            color: Colors.black
        ),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          focusColor: Colors.transparent,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)
          ),
        ),
        onChanged: (value) {
          credentials[credential!] = value;
        },
      ),
      decoration: BoxDecoration(
          color: const Color(0xFFD6D6D6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 5)
      )
    );
  }

}
