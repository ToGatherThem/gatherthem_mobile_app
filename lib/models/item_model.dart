class ItemModel {
  String id;
  String label;
  String creationDate;
  String obtentionDate;

  ItemModel.fromJson(Map json):
    id = json["id"],
    label = json["label"],
    creationDate = json["creationDate"],
    obtentionDate = json["obtentionDate"];
}