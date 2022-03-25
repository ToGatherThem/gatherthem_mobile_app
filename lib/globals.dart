import 'package:gatherthem_mobile_app/blocs/bloc_collection.dart';

///Map for login purpose
late Map<String, String> credentials = { "username": "", "password": "", "confirm_password": "", "email": "" };
late Map<String, String> addCollection = { "type": "", "name": "", "description": "" };

///String from api host
String apiHost = "http://localhost:8080";

///Bloc for collection list
BlocCollection blocCollection = BlocCollection();
