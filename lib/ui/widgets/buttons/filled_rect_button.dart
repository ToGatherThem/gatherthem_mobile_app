import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';

class FilledRectButton extends StatelessWidget {
  const FilledRectButton({Key? key}) : super(key: key);

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
        child: const Text("Se connecter"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
      ),
    );
  }
}