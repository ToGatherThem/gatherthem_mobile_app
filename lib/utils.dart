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
}