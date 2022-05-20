import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:intl/intl.dart';

class Utils {
  static convertUTCToLocalString(String utcDate) {
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(utcDate).toLocal();
    return DateFormat(Strings.dayFormat).format(dateValue);
  }
}