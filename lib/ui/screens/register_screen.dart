import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
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
                      Text(Strings.appTitle,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30
                          )
                      ),
                      const SizedBox(height: 80),
                      Align(
                        child: Text(Strings.emailLabel,
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
                        child: Text(Strings.userNameLabel,
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
                        child: Text(Strings.passwordLabel,
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
                        child: Text(Strings.confirmPasswordLabel,
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
                      FilledRectButton(text: Strings.signUpLabel, onPressed: (){
                        validate(context);
                      }),
                      const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            textStyle: const TextStyle(fontSize: 15)
                        ),
                        child: const Text(Strings.noAccountLabel),
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
      errorText = Strings.emailRequired;
    } else if (!regex.hasMatch(credentials["email"]!)) {
      errorText = Strings.emailNotValid;
    } else if (credentials["username"] == null || credentials["username"]!.isEmpty) {
      errorText = Strings.usernameRequired;
    } else if (credentials["password"] == null || credentials["password"]!.isEmpty) {
      errorText = Strings.passwordRequired;
    } else if (credentials["confirm_password"] == null || credentials["confirm_password"]!.isEmpty) {
      errorText = Strings.confirmPasswordRequired;
    } else if (credentials["password"] != credentials["confirm_password"]) {
      errorText = Strings.passwordsDontMatch;
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
                    child: const Text(Strings.okLabel),
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