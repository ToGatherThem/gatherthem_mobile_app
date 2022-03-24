import 'dart:convert';
import 'package:dio/dio.dart';

abstract class Service {

  late Dio dio;
  late Options options;

  initDio(){
    dio = Dio();
    options = Options(headers: {
      "Accept": "application/json",

    });
  }

  Future<dynamic> request(String urlString) async {
    //print(urlString);
    final result = await dio.get(
        urlString,
        options: options
    );
    final body = json.decode(json.encode(result.data)); //For REST
    //final body = json.decode(result.data); //For HTTP
    return body;
  }
}