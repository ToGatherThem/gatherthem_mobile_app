import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';

class ItemService extends Service {

  Future<dynamic> editItem(String id, ItemInfosModel itemInfos, BuildContext context) {
    return put('$apiHost/items/$id', itemInfos.toJson(), context)
        .catchError((e){
      if(e.response.statusCode == 404){
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(child: const Text(Strings.itemDoesntExist),);
      }
    });
  }
  
  Future<bool> deleteItem(String id, BuildContext context) async{
    return await delete(apiHost+"/items/"+id, context)
        .catchError((e){
      if(e.response.statusCode == 404){
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(child: const Text(Strings.itemDoesntExist));
      }
    });
  }

  Future<ItemModel> fetchItem(String id, BuildContext context) async {
    Map<String, dynamic> data = await json.decode(await get(apiHost+"/items/"+id, context))
        .catchError((e){
      if(e.response.statusCode == 404){
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(child: const Text(Strings.itemDoesntExist));
      }
    });
    return ItemModel.fromJson(data);
  }

  Future<List<ItemModel>> fetchPublicItems(BuildContext context) async {
    List<dynamic> resultRequest = await getList(apiHost + "/items/public", context);
    return resultRequest.map((json) => ItemModel.fromJson(json)).toList();
  }
}