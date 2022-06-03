import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';


class CollectionService extends Service {

  Future<dynamic> createCollection(CollectionInfosModel collectionInfosModel, BuildContext context){
    return post(apiHost + "/collections", collectionInfosModel.toJson(), context)
    .catchError((e) {
      if(e.response.statusCode == 404){
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(child: const Text(Strings.templateDoesntExist),);
      }
    });
  }

  Future<List<CollectionModel>> fetchCollections(BuildContext context) async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections", context);
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }

  Future<List<ItemModel>> fetchCollectionItems(String id, BuildContext context) async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections/"+id+"/items", context)
      .catchError((e){
        if(e.response.statusCode == 404){
          FToast fToast = FToast();
          fToast.init(context);
          fToast.showToast(child: const Text(Strings.collectionDoesntExist),);
        }
      });
    return resultRequest.map((json) => ItemModel.fromJson(json)).toList();
  }

  Future<bool> deleteCollection(String id, BuildContext context) async{
    return await delete(apiHost + "/collections?id=" + id, context)
      .catchError((e){
        if(e.response.statusCode == 404){
          FToast fToast = FToast();
          fToast.init(context);
          fToast.showToast(child: const Text(Strings.collectionDoesntExist),);
        }
      });
  }

  Future<dynamic> editCollection(CollectionInfosModel collectionInfosModel, String id, BuildContext context) {
    return put(apiHost + "/collections?id="+id, collectionInfosModel.toJson(), context)
        .catchError((e){
      if(e.response.statusCode == 404){
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(child: const Text(Strings.collectionDoesntExist),);
      }
    });
  }

  Future<dynamic> addItem( CollectionModel collectionModel, ItemInfosModel itemInfosModel, BuildContext context) {
    String url = apiHost + "/collections/" + collectionModel.id + "/items";
    return post(url, itemInfosModel.toJson(), context)
        .catchError((e){
      if(e.response.statusCode == 404){
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(child: const Text(Strings.collectionDoesntExist),);
      }
    });
  }

  Future<List<CollectionModel>> fetchPublicCollections(BuildContext context) async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections/public", context);
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }
}