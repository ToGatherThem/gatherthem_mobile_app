import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_collection.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class ServiceCollection extends Service {
  Future<String> fetchCollection() async {
    initDio();
    var resultRequest = await request("http://localhost:8080/collections");
    String title = resultRequest.first['name'];//[0]['titre'];
    print("service " + title);
    return title;
  }
}