import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class UserService extends Service {

  Future<ProfileModel?> getProfile(BuildContext context) async{
    var url = apiHost + "/user/me";
    Map<String, dynamic> user = await json.decode(await get(url, context));
    return ProfileModel.fromJson(user);
  }
}