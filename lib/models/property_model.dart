class PropertyModel {
  String id;
  String name;
  String type;

  PropertyModel.fromJson(Map json) :
    id = json['id'],
    name = json['name'],
    type = json['type'];
}