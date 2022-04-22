class TemplateModel {
  String id;
  String name;
  String description;
  String itemLabelName;
  String visibility;

  TemplateModel.fromJson(Map json) :
    id = json['id'],
    name = json['name'],
    description = json['description'],
    itemLabelName = json['itemLabelName'],
    visibility = json['visibility'];
}