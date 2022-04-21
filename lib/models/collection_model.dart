
class CollectionModel{
  String id;
  String name;
  String description;
  String creationDate;

  CollectionModel.fromJson(Map json):
    id = json['id'],
    name = json['name'],
    description = json['description'],
    creationDate = json['creationDate'];

  CollectionModel.empty():
    id = "",
    name = "",
    description = "",
    creationDate = "";
}