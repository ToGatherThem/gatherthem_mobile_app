import 'collection_item_property_model.dart';

class CollectionItemModel{
  String id;
  String label;
  String obtentionDate;
  //List<CollectionItemProperty> properties;
  CollectionItemModel.fromJson(Map json):
        id = json['id'],
        label = json['label'],
        obtentionDate = json['obtentionDate']
      ;


}
