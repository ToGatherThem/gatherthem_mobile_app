import 'package:gatherthem_mobile_app/models/property_model.dart';

class TemplateModel {
  String id;
  String name;
  String description;
  String itemLabelName;
  String visibility;
  TemplateModel? parent;
  List<PropertyModel> properties;


  TemplateModel(this.id, this.name, this.description, this.itemLabelName,
      this.visibility, this.parent, this.properties);

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      json['id'],
      json['name'],
      json['description'],
      json['itemLabelName'],
      json['visibility'],
      (json['parent'] != null) ? TemplateModel.fromJson(json['parent']) : null,
      json['properties'] != null ? (json['properties'] as List).map((i) => PropertyModel.fromJson(i)).toList() : [],
    );
  }

  String get fullName => parent?.fullName != null ? "${parent?.fullName}/$name" : name;

  List<PropertyModel> get allProperties {
    List<PropertyModel> allProperties = [];
    allProperties.addAll(properties);
    if (parent != null) {
      allProperties.addAll(parent!.allProperties);
    }
    return allProperties;
  }
}