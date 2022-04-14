class ItemModel {
  String id;
  String label;
  String creationDate;

  ItemModel.fromJson(Map json):
    id = json["id"],
    label = json["label"],
    creationDate = json["creationDate"];
}