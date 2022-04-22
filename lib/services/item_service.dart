import 'dart:convert';

import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class ItemService extends Service {

  Future<dynamic> editItem(String id, ItemInfosModel itemInfos) {
    return put('$apiHost/items/$id', itemInfos.toJson());
  }
  
  Future<bool> deleteItem(String id) async{
    return await delete(apiHost+"/items/"+id);
  }

  Future<ItemModel> fetchItem(String id) async {
    Map<String, dynamic> data = await json.decode(await get(apiHost+"/items/"+id));
    return ItemModel.fromJson(data);
  }
}