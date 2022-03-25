import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';

class AuthenticationService extends Service {

  login(BuildContext context, String username, String password) {
    String url = apiHost + "/user/login";
    post(url, { "username": username, "password": password })
        .catchError((e) {
          if (e.response != null && e.response.statusCode == 401) {
            openDialog(context, "Connexion échouée : les identifiants sont incorrects");
          } else {
            openDialog(context, "Connexion échouée : Une erreur est survenue");
          }
        })
        .then((value) {
          if (value != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        });
  }

  register(BuildContext context, String email, String username, String password) {
    String url = apiHost + "/user/register";
    post(url, { "email": email, "username": username, "password": password })
        .catchError((e) {
          if (e.response.statusCode == 409) {
            openDialog(context, "Inscription échouée : les identifiants sont déjà pris");
          }
        })
        .then((value) {
          if (value != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
        });
  }

  openDialog(context, errorText) {
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
}