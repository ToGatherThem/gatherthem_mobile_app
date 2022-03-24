import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';

class AuthenticationService extends Service {

  login(BuildContext context, String username, String password) {
    const url = "http://localhost:8080/user/login";
    requestPost(url, { "username": username, "password": password })
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  register(BuildContext context) {
    const url = "http://localhost:8080/user/register";
  }
}