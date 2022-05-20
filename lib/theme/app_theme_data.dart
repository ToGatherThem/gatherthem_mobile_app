import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/custom_colors.dart';

ThemeData buildLightTheme(){
  return ThemeData(
    scaffoldBackgroundColor: CustomColors.lightBackground,
    brightness: Brightness.light,
    backgroundColor: CustomColors.lightBackground,
    cardColor: CustomColors.lightCard,
    bottomAppBarColor: CustomColors.lightMenu,
    primaryColor: CustomColors.lightFont,
    highlightColor: CustomColors.lightHighlight,
  );
}

ThemeData buildDarkTheme(){
  return ThemeData(
    scaffoldBackgroundColor: CustomColors.darkBackground,
    brightness: Brightness.dark,
    backgroundColor: CustomColors.darkBackground,
    cardColor: CustomColors.darkCard,
    bottomAppBarColor: CustomColors.darkMenu,
    primaryColor: CustomColors.darkFont,
    highlightColor: CustomColors.darkHighlight,
  );
}