import 'dart:convert';
import 'dart:typed_data';

import 'package:gatherthem_mobile_app/models/template_model.dart';

class CollectionModel{
  String id;
  String name;
  String description;
  Uint8List? image;
  String creationDate;
  TemplateModel template;

  CollectionModel.fromJson(Map json):
    id = json['id'],
    name = json['name'],
    description = json['description'],
    image = (json["image"] != null) ? const Base64Decoder().convert(json["image"]).buffer.asUint8List() : null,
    creationDate = json['creationDate'],
    template = TemplateModel.fromJson(json['template']);
}