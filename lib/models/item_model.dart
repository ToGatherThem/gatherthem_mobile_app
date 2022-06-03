import 'package:gatherthem_mobile_app/models/item_property_model.dart';

class ItemModel {
  String id;
  String label;
  String creationDate;
  String obtentionDate;
  List<ItemPropertyModel> properties;

  ItemModel.fromJson(Map json):
    id = json["id"],
    label = json["label"],
    creationDate = json["creationDate"],
    obtentionDate = json["obtentionDate"],
    properties = (json["properties"] as List).map((e) => ItemPropertyModel.fromJson(e)).toList();

  getPropertyValue(String propertyId) {
    int index = properties.indexWhere((element) => element.property.id == propertyId);
    if (index != -1) {
      return properties[index].value;
    } else {
      return "";
    }
  }
}