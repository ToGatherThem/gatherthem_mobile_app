import 'package:gatherthem_mobile_app/blocs/bloc_collection.dart';

///Map for login purpose
late Map<String, String> credentials = { "username": "", "password": "", "confirm_password": "", "email": "" };

///Map for collections modification/addition
late Map<String, String> editCollection={"name":"","type":"","description":""};
///String from api host
String apiHost = "http://localhost:8080";

///Bloc for collection list
BlocCollection blocCollection = BlocCollection();
