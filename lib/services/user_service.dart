import 'dart:convert';

import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class UserService extends Service {

  Future<ProfileModel?> getProfile() async{
    var url = apiHost + "/user/me";
    Map<String, dynamic> user = await json.decode(await get(url));
    return ProfileModel.fromJson(user);
  }
}