import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:intl/intl.dart';

class Utils {
  static convertUTCToLocalString(String utcDate) {
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(utcDate).toLocal();
    return DateFormat(Strings.dayFormat).format(dateValue);
  }

  static formatStringDate(String date) {
    var dateParts = date.split('-');
    var year = dateParts[0];
    var month = dateParts[1];
    var day = dateParts[2];
    return '$day/$month/$year';
  }

   static openDialog(context, errorText) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Text(errorText),
            ),
            actions: [
              Center(
                child: TextButton(
                    child: const Text("OK"),
                    onPressed: () { Navigator.of(context).pop(); }
                ),
              ),
            ],
          );
        }
    );
  }

  static String propertyTypeToHumanText(String propertyType) {
    switch (propertyType) {
      case 'TEXT':
        return Strings.propertyTypeText;
      case 'LONGTEXT':
        return Strings.propertyTypeLongText;
      case 'DATE':
        return Strings.propertyTypeDate;
      case 'INTEGER':
        return Strings.propertyTypeInteger;
      case 'DURATION':
        return Strings.propertyTypeDuration;
      default:
        return Strings.propertyTypeUnknown;
    }
  }
}