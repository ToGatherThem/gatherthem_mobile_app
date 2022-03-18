import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Center(
              child: Image.asset("assets/logo.png",
                color: Colors.white.withOpacity(0.2),
                colorBlendMode: BlendMode.modulate
              )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("GatherThem",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30
                    )
                ),
                const SizedBox(height: 150),
                Align(
                  child: Text("Nom d'utilisateur",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15
                      )
                  ),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 10),
                const TextInput(),
                const SizedBox(height: 30),
                Align(
                  child: Text("Mot de passe",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15
                      )
                  ),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 10),
                const TextInput(),
                const SizedBox(height: 30),
                const FilledRectButton()
              ],
            ),
          )
        ],
      ),
    );
  }

}