import 'dart:async';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';
import 'package:gatherthem_mobile_app/utils.dart';

abstract class Service{
  late Dio dio;
  late Options options;
  static late CookieJar cookieJar = CookieJar();

  Service() {
    dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
    options = Options(
      headers: { "Accept": "application/json" },
      responseType: ResponseType.plain
    );
  }

  Future<dynamic> get(String urlString, BuildContext context) async {
    //print(urlString);
    final result = await dio.get(
        urlString,
        options: options
    ).catchError((e) {
      handleError(e, context);
    });
    final body = json.decode(json.encode(result.data));
    return body;
  }

  Future<dynamic> getList(String urlString, BuildContext context) async {
    //print(urlString);
    final result = await dio.get(
        urlString,
        options: options
    ).catchError((e) {
      handleError(e, context);
    });
    final body = json.decode(result.data);
    return body;
  }

  Future<dynamic> post(String urlString, dynamic data, BuildContext context) async {
    final result = await dio.post(
        urlString,
        data: data,
        options: options
    ).catchError((e) {
      return handleError(e, context);
    });
    final body = json.decode(json.encode(result.data));
    return body;
  }

  Future<dynamic> put(String urlString, dynamic data, BuildContext context) async {
    final result = await dio.put(
        urlString,
        data: data,
        options: options
    ).catchError((e) {
      handleError(e, context);
    });
    final body = json.decode(json.encode(result.data));
    return body;
  }

  Future<bool> delete(String urlString, BuildContext context) async {
    final result = await dio.delete(
        urlString,
        options: options
    ).catchError((e) {
      handleError(e, context);
    });
    return result.statusCode == 200;
  }


  FutureOr<Response<dynamic>> handleError(DioError e, BuildContext context) {
    if(e.type == DioErrorType.other || e.response != null && e.response!.statusCode == 500 ) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => true
      );
      Utils.openDialog(context, "Une erreur inattendu est survenue, veuillez réessayer plus tard");
      return Future.error(e);
    }
    else if (e.response != null && e.response!.statusCode == 403) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => true
      );
      return Future.error(e);
    }
    return Future.error(e);

  }
}