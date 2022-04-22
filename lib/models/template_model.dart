class TemplateModel {
  String id;
  String name;
  String description;
  String itemLabelName;
  String visibility;
  TemplateModel? parent;

  TemplateModel.fromJson(Map json) :
    id = json['id'],
    name = json['name'],
    description = json['description'],
    itemLabelName = json['itemLabelName'],
    visibility = json['visibility'],
    parent = (json['parent'] != null) ? TemplateModel.fromJson(json['parent']) : null;

  String get fullName => parent?.fullName != null ? "${parent?.fullName}/$name" : name;
}