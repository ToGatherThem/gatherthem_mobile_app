import 'item_property_model.dart';

class CollectionItemProperty {
  String id;
  String value;
  Property property;

  CollectionItemProperty.fromJson(Map json):
      id = json['properties']['id'],
      value = json['properties']['value'],
      property = json['properties']['property'];
}

