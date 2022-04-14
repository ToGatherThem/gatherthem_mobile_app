import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/ui/screens/profile_screen.dart';

class UserService extends Service {

  getProfile(BuildContext context) {
    var url = apiHost + "/user/me";
    get(url).then((value) {
      if (value != null) {
        Map profile = json.decode(value);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(profile: profile)));
      }
    });
  }
}