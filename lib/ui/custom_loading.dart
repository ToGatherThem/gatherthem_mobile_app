import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomLoading {
  static customLoadingStyleAndShow(
      {required BuildContext context,
        String? status,
      Color? progressColor,
      Color? backgroundColor,
      double? indicatorSize,
      double? progressPadding,
      double? radius,
      EasyLoadingIndicatorType? indicatorType
      }) {

    Color progressColorVal = progressColor ?? Theme.of(context).primaryColor;
    Color backgroundColorVal =
        backgroundColor ?? Theme.of(context).backgroundColor;
    double indicatorSizeVal = indicatorSize ?? 30;
    double radiusVal = radius ?? 10;
    EasyLoadingIndicatorType indicatorTypeVal = indicatorType ?? EasyLoadingIndicatorType.wave;
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = indicatorTypeVal
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = indicatorSizeVal
      ..radius = radiusVal
      ..progressColor = progressColorVal
      ..backgroundColor = backgroundColorVal.withOpacity(0.9)/*backgroundColorVal*/
      ..indicatorColor = progressColorVal
      ..textColor = progressColorVal
      ..maskColor = Colors.grey.withOpacity(0.3)
      ..userInteractions = false
      ..dismissOnTap = false;

    String statusVal = status ?? 'Veuillez patienter...';
    EasyLoading.show(status: statusVal);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }

  static success({String? message}) {
    String messageVal = message ?? 'Terminé';
    EasyLoading.showSuccess(messageVal,
        duration: const Duration(milliseconds: 100));
  }
}
