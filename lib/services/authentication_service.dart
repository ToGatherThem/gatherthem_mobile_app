import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';
import 'package:gatherthem_mobile_app/utils.dart';


/// Specialized service for authentication
class AuthenticationService extends Service {

  login(BuildContext context, String username, String password) {
    String url = apiHost + "/user/login";
    post(url, { "username": username, "password": password }, context)
        .catchError((e) {
          if (e.response != null && e.response.statusCode == 401) {
            Utils.openDialog(context, Strings.error401);
          }
        })
        .then((value) {
          if (value != null) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
          }
        });
  }

  logout(BuildContext context) {
    String url = apiHost + "/user/logout";
    get(url, context)
        .then((value) {
          if (value != null) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
          }
        });
  }

  register(BuildContext context, String email, String username, String password) {
    String url = apiHost + "/user/register";
    post(url, { "email": email, "username": username, "password": password }, context)
        .catchError((e) {
          if (e.response != null && e.response.statusCode == 409) {
            Utils.openDialog(context, Strings.error409);
          }
        })
        .then((value) {
          if (value != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
        });
  }
}