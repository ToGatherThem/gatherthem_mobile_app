class CollectionModel{
  String id;
  //String owner_id;
  String type;
  String name;
  String description; //?
  int created_at;
  //List<String> properties;

  CollectionModel.fromJson(Map json):
    id = json['id'],
    type = json['type'],
    name = json['name'],
    description = json['description'],
    created_at = json['creationDate'];


}
//[ { "id": "a36f30f0-63aa-43c5-b9b6-09f94b9a0644",
// "owner_id": "51e18d3c-88f5-4917-97d1-2ee3ed9be3b5",
// "type": "Livres", "name": "Mes livres de fantasy",
// "description": "J'adore vraiment beaucoup très très énormement ces livres",
// "created_at": 1647509337, "properties"