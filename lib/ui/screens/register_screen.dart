import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6, vertical: 20),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("GatherThem",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30
                        )
                    ),
                    const SizedBox(height: 80),
                    Align(
                      child: Text("Email",
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
                    Align(
                      child: Text("Confirmer le mot de passe",
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
                    const FilledRectButton(text: "S'inscrire", targetWidget: HomeScreen()),
                    const SizedBox(height: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 15)
                      ),
                      child: const Text("Déjà un compte ? Se connecter"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}