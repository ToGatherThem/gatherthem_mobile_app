import 'package:gatherthem_mobile_app/blocs/bloc_collections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/bloc_items.dart';

///Map for login purpose
late Map<String, String> credentials = { "username": "", "password": "", "confirm_password": "", "email": "" };

///String from api host
String apiHost = "http://localhost:8080";

///Bloc for collection list
BlocCollection blocCollection = BlocCollection();

late BlocItems blocItems;

late SharedPreferences sharedPreferences;