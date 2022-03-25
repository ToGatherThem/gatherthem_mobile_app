import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_form_input.dart';

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
          Center(
            child: Padding(
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
                      const TextInput(credential: "email"),
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
                      const TextInput(credential: "username"),
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
                      const TextInput(credential: "password", obscureText: true),
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
                      const TextInput(credential: "confirm_password", obscureText: true),
                      const SizedBox(height: 30),
                      FilledRectButton(text: "S'inscrire", onPressed: (){
                        validate(context);
                      }),
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
            ),
          )
        ],
      ),
    );
  }

  validate(context) {
    String errorText = "";
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    if (credentials["email"] == null || credentials["email"]!.isEmpty) {
      errorText = "L'email n'est pas renseigné";
    } else if (!regex.hasMatch(credentials["email"]!)) {
      errorText = "L'email n'est pas valide";
    } else if (credentials["username"] == null || credentials["username"]!.isEmpty) {
      errorText = "Le nom d'utilisateur n'est pas renseigné";
    } else if (credentials["password"] == null || credentials["password"]!.isEmpty) {
      errorText = "Le mot de passe n'est pas renseigné";
    } else if (credentials["confirm_password"] == null || credentials["confirm_password"]!.isEmpty) {
      errorText = "Le mot de passe n'a pas été confirmé";
    } else if (credentials["password"] != credentials["confirm_password"]) {
      errorText = "Les mots de passe ne sont pas identiques";
    }

    if (errorText != "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Text(errorText),
              ),
              actions: [
                Center(
                  child: TextButton(
                    child: const Text("OK"),
                    onPressed: () { Navigator.of(context).pop(); }
                  ),
                ),
              ],
            );
          }
      );
    }

    AuthenticationService().register(context, credentials["email"]!, credentials["username"]!, credentials["password"]!);
  }

}