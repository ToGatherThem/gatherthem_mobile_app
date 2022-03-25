import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';

class CollectionService extends Service {

  createCollection(BuildContext context, String type, String name, String description) {
    post(apiHost + "/collections", {
      'type': type,
      'name': name,
      'description': description,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
    }).then((value) {
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  Future<List<CollectionModel>> fetchCollections() async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections");
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }

  Future<bool> deleteCollection(String id) async{
    return await delete(apiHost + "/collections?id=" + id);
  }

  void editCollection(BuildContext context, String name, String type, String description, String id) {
    patch(apiHost + "/collections?id="+id, {
      'type': type,
      'name': name,
      'description': description,
    }).then((value) {
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }
}