import 'package:gatherthem_mobile_app/models/collection_item_model.dart';

class CollectionModel{
  String id;
  String name;
  String description;
  String creationDate;
  List<CollectionItemModel> items;

  CollectionModel.fromJson(Map json):
    id = json['id'],
    name = json['name'],
    description = json['description'],
    creationDate = json['creationDate']
    ,items = json['properties']
  ;

  CollectionModel.empty():
    id = "",
    name = "",
    description = "",
    creationDate = "";

}