import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class CollectionService extends Service {
  createCollection(String type, String name, String description) {
    requestPost('$apiHost/collections', {
      'type': type,
      'name': name,
      'description': description,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
    });
  }
}