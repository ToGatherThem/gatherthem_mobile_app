class TemplateInfosModel{
  late String name = "";
  late String description = "";
  late String itemLabelName = "Nom";
  late String visibility = "PRIVATE";
  late String parentId = "";

  toJson() {
    return {
      'name': name,
      'description': description,
      'itemLabelName': itemLabelName,
      'visibility': visibility,
      'parentId': parentId,
      'properties': []
    };
  }
}