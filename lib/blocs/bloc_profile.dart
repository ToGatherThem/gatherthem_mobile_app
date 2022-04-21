import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class BlocProfile extends Bloc{

  final _streamController = BehaviorSubject<ProfileModel>();

  Stream<ProfileModel> get stream => _streamController.stream;

  Sink<ProfileModel> get sink => _streamController.sink;

  fetchProfile() async {
    var resultRequest = await UserService().getProfile();
    if(resultRequest != null){
      setProfile(resultRequest);
    }
  }

  setProfile(ProfileModel profileModel) async {
    sink.add(profileModel);
  }
  @override
  void dispose() {
    _streamController.close();
  }
}