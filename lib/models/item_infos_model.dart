import 'dart:typed_data';

import 'package:gatherthem_mobile_app/models/item_property_creation_model.dart';

class ItemInfosModel {
  late String label = "";
  late String obtentionDate = "";
  Uint8List? image;
  List<ItemPropertyCreationModel> properties = [];


  toJson() {
    return {
      "label": label,
      "obtentionDate": obtentionDate,
      "image": image,
      "properties": properties.map((e) => e.toJson()).toList()
    };
  }
  
  setProperty(String id, String propertyId, String value) {
    int index = properties.indexWhere((element) => element.propertyId == propertyId);
    if (index != -1) {
      properties[index].value = value;
    } else {
      properties.add(ItemPropertyCreationModel(id, propertyId, value));
    }
  }
}