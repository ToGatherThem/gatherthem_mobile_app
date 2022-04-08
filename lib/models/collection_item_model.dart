import 'collection_item_property_model.dart';

class CollectionItemModel{
  int id;
  String label;
  DateTime creationDate;
  List<CollectionItemProperty> properties;
  CollectionItemModel.fromJson(Map json):
        id = json['id'],
        label = json['type'],
        creationDate = json['creationDate'],
        properties = json['items']['id']
      ;


}

