
class CollectionModel{
  String id;
  String name;
  String description;
  String creationDate;
  //List<CollectionItemModel> items;

  CollectionModel.fromJson(Map json):
    id = json['id'],
    name = json['name'],
    description = json['description'],
    creationDate = json['creationDate']
    //,items = json['items']
  ;
  // setItems(){
  //   items = CollectionItemModel.fromJson(Map json):
  //
  //
  // }
  CollectionModel.empty():
    id = "",
    name = "",
    description = "",
    creationDate = ""
    //,items = []
  ;
}