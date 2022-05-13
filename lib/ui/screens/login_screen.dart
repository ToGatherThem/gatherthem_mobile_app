import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/register_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';

import '../widgets/inputs/text_form_input.dart';

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
                        child: Text(Strings.userNameLabel,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15
                            )
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(height: 10),
                      const TextFormInput(credential: "username"),
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
                      const TextFormInput(credential: "password", obscureText: true),
                      const SizedBox(height: 30),
                      FilledRectButton(text: Strings.loginLabel, onPressed: (){
                        AuthenticationService().login(
                            context,
                            credentials["username"]!,
                            credentials["password"]!
                        );
                      }),
                      const SizedBox(height: 10),
                      FilledRectButton(text: "Admin", onPressed: (){
                        AuthenticationService().login(
                            context,
                            "admin",
                            "exemple"
                        );
                      }),
                      const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            textStyle: const TextStyle(fontSize: 15)
                        ),
                        child: const Text(Strings.noAccountLabel),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
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

}