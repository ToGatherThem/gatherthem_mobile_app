import 'dart:convert';
import 'dart:typed_data';

class ItemModel {
  String id;
  String label;
  String creationDate;
  String obtentionDate;
  Uint8List? image;

  ItemModel.fromJson(Map json):
    id = json["id"],
    label = json["label"],
    creationDate = json["creationDate"],
    obtentionDate = json["obtentionDate"],
    image = (json["image"] != null) ? const Base64Decoder().convert(json["image"]).buffer.asUint8List() : null;
}