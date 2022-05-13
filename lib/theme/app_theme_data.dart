import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/custom_colors.dart';

ThemeData buildLightTheme(){
  return ThemeData(
    brightness: Brightness.light,
    backgroundColor: CustomColors.lightBackground,
    cardColor: CustomColors.lightCard,
    bottomAppBarColor: CustomColors.lightMenu,
    focusColor: CustomColors.lightContrast,
    primaryColor: CustomColors.lightFont,
    highlightColor: CustomColors.lightHighlight,
  );
}

ThemeData buildDarkTheme(){
  return ThemeData(
    brightness: Brightness.dark,
    backgroundColor: CustomColors.darkBackground,
    cardColor: CustomColors.darkCard,
    bottomAppBarColor: CustomColors.darkMenu,
    focusColor: CustomColors.darkContrast,
    primaryColor: CustomColors.darkFont,
    highlightColor: CustomColors.darkHighlight,
  );
}