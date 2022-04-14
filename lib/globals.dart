import 'package:gatherthem_mobile_app/blocs/bloc_collection.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_collection_item.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';

///Map for login purpose
late Map<String, String> credentials = { "username": "", "password": "", "confirm_password": "", "email": "" };

///String from api host
String apiHost = "http://localhost:8080";

///Bloc for collection list
BlocCollection blocCollection = BlocCollection();

late CollectionModel currentCollection = CollectionModel.empty();
