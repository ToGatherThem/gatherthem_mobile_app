import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class BlocProfile extends Bloc {
  final _streamController = BehaviorSubject<ProfileModel>();

  Stream<ProfileModel> get stream => _streamController.stream;

  Sink<ProfileModel> get sink => _streamController.sink;

  fetchProfile(BuildContext context) async {
    var resultRequest = await UserService().getProfile(context);
    if (resultRequest != null) {
      setProfile(resultRequest);
    }
  }

  setProfile(ProfileModel profileModel) async {
    sink.add(profileModel);
  }

  buyPremium(BuildContext context, String username, String password) async {
    UserService()
        .buyPremium(context)
        .then((value) =>
            AuthenticationService().login(context, username, password))
        .then((value) => fetchProfile(context));
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
