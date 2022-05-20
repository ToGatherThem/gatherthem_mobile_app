import 'package:gatherthem_mobile_app/models/template_model.dart';

class CollectionModel{
  String id;
  String name;
  String description;
  String creationDate;
  TemplateModel template;

  CollectionModel.fromJson(Map json):
    id = json['id'],
    name = json['name'],
    description = json['description'],
    creationDate = json['creationDate'],
    template = TemplateModel.fromJson(json['template']);
}