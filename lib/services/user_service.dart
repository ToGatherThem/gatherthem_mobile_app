import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/models/user_update_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';

class UserService extends Service {

  Future<ProfileModel?> getProfile(BuildContext context) async{
    var url = apiHost + "/user/me";
    Map<String, dynamic> user = await json.decode(await get(url, context));
    return ProfileModel.fromJson(user);
  }

  Future<ProfileModel> buyPremium(BuildContext context) async {
    var url = apiHost + "/user/premium";
    Map<String, dynamic> user = await json.decode(await put(url, {}, context));
    return ProfileModel.fromJson(user);
  }

  Future<dynamic> updateProfile(BuildContext context, UserUpdateModel userInfos) {
    return put(apiHost + "/user/update", userInfos.toJson(), context)
      .catchError((e) {
        if (e.response != null && e.response.statusCode == 401) {
          FToast fToast = FToast();
          fToast.init(context);
          fToast.showToast(
            child: const Text(Strings.error401UserUpdate),
          );
        } else if (e.response != null && e.response.statusCode == 404) {
          FToast fToast = FToast();
          fToast.init(context);
          fToast.showToast(
            child: const Text(Strings.userDoesntExist),
          );
        }
      }
    );
  }
}