import 'package:gatherthem_mobile_app/blocs/bloc_collections.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_profile.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_templates.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/bloc_items.dart';

///Map for login purpose
late Map<String, String> credentials = { "username": "", "password": "", "confirm_password": "", "email": "" };

///String from api host
String apiHost = "https://gatherthem.bryanprolong.fr";

///Bloc for collection list
BlocCollection blocCollection = BlocCollection();
BlocTemplates blocTemplates = BlocTemplates();

///Bloc to manage the collection items
late BlocItems blocItems;

///Variable to store information in the device storage
late SharedPreferences sharedPreferences;

///Bloc to manage information about the user
late BlocProfile blocProfile;