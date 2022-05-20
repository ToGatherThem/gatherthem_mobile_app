import 'package:flutter/material.dart';

class Styles{
  static TextStyle getTextStyle(BuildContext context, {Color? color, FontWeight? weight}) {
    return TextStyle(
      fontWeight: weight ?? FontWeight.w400,
      fontSize: 16,
      color: color ?? Theme.of(context).primaryColor,
    );
  }

  static TextStyle getTitleStyle(BuildContext context, {Color? color, FontWeight? weight}) {
    return TextStyle(
      fontWeight: weight ?? FontWeight.bold,
      fontSize: 35,
      color: color ?? Theme.of(context).primaryColor,
    );
  }

  static TextStyle getPseudoStyle(BuildContext context, {Color? color, FontWeight? weight}) {
    return TextStyle(
      fontWeight: weight ?? FontWeight.bold,
      fontSize: 24,
      color: color ?? Theme.of(context).primaryColor,
    );
  }

  static TextStyle getFigureStyle(BuildContext context, {Color? color, FontWeight? weight}) {
    return TextStyle(
      fontWeight: weight ?? FontWeight.bold,
      fontSize: 20,
      color: color ?? Theme.of(context).primaryColor,
    );
  }
}