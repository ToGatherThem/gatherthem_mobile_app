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
}