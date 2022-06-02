import 'dart:convert';
import 'dart:typed_data';
import 'package:gatherthem_mobile_app/models/item_property_model.dart';

class ItemModel {
  String id;
  String label;
  String creationDate;
  String obtentionDate;
  Uint8List? image;
  List<ItemPropertyModel> properties;

  ItemModel.fromJson(Map json):
    id = json["id"],
    label = json["label"],
    creationDate = json["creationDate"],
    obtentionDate = json["obtentionDate"],
    image = (json["image"] != null) ? const Base64Decoder().convert(json["image"]).buffer.asUint8List() : null,
    properties = (json["properties"] as List).map((e) => ItemPropertyModel.fromJson(e)).toList();
}