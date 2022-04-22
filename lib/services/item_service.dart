import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class ItemService extends Service {

  Future<dynamic> editItem(String id, ItemInfosModel itemInfos) {
    return put('$apiHost/items?id=$id', itemInfos.toJson());
  }
  
  Future<bool> deleteItem(String id) async{
    return await delete(apiHost+"/items?id="+id);
  }
}

