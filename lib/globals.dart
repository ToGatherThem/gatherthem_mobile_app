import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_collections.dart';

import 'blocs/bloc_items.dart';

///Map for login purpose
late Map<String, String> credentials = { "username": "", "password": "", "confirm_password": "", "email": "" };

///String from api host
String apiHost = "http://localhost:8080";

///Bloc for collection list
BlocCollection blocCollection = BlocCollection();

late BlocItems blocItems;

TextStyle getTextStyle(BuildContext context, {Color? color, FontWeight? weight}) {
  return TextStyle(
    fontWeight: weight ?? FontWeight.w400,
    fontSize: 16,
    color: color ?? Theme.of(context).primaryColor,
  );
}

TextStyle getTitleStyle(BuildContext context, {Color? color, FontWeight? weight}) {
  return TextStyle(
    fontWeight: weight ?? FontWeight.bold,
    fontSize: 35,
    color: color ?? Theme.of(context).primaryColor,
  );
}