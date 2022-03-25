class CollectionObject{
  int id;
  String owner_id;
  String type;
  String name;
  String description; //?
  String created_at;
  List<String> properties;

  CollectionObject( {required this.id,  required this.owner_id, required this.type,
    required this.name, required this.description,required  this.created_at,
    required this.properties});


}
//[ { "id": "a36f30f0-63aa-43c5-b9b6-09f94b9a0644",
// "owner_id": "51e18d3c-88f5-4917-97d1-2ee3ed9be3b5",
// "type": "Livres", "name": "Mes livres de fantasy",
// "description": "J'adore vraiment beaucoup très très énormement ces livres",
// "created_at": 1647509337, "properties"