class Property {
  String id;
  String name;
  String type;

  Property.fromJson(Map json):
      id=json['properties']['property']['id'],
      name=json['properties']['property']['name'],
      type=json['properties']['property']['type'];
}