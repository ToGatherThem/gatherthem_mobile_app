import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';

class ItemService extends Service {
  
  addItem(BuildContext context, CollectionModel collectionModel, ItemInfosModel itemInfosModel) {
    String url = apiHost + "/collections/" + collectionModel.id + "/items";
    post(url, itemInfosModel.toJson()).then((value) {
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionScreen(collection: collectionModel)));
      }
    });
  }
}