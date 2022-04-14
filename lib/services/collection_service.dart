import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';

import '../models/collection_item_model.dart';

class CollectionService extends Service {

  createCollection(BuildContext context, CollectionInfosModel collectionInfosModel) {
    post(apiHost + "/collections", collectionInfosModel.toJson()).then((value) {
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  Future<List<CollectionModel>> fetchCollections() async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections");
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }
  Future<List<CollectionItemModel>> fetchCollectionItems(String id) async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections/"+id+"/items");
    return resultRequest.map((json) => CollectionItemModel.fromJson(json)).toList();
  }

  Future<bool> deleteCollection(String id) async{
    return await delete(apiHost + "/collections?id=" + id);
  }

  void editCollection(BuildContext context, CollectionInfosModel collectionInfosModel, String id) {
    put(apiHost + "/collections?id="+id, collectionInfosModel.toJson()).then((value) {
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }
}