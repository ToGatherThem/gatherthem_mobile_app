import 'package:gatherthem_mobile_app/models/property_creation_model.dart';

class TemplateInfosModel{
  late String name = "";
  late String description = "";
  late String itemLabelName = "Nom";
  late String visibility = "PRIVATE";
  late String parentId = "";
  late List<PropertyCreationModel> properties = [];

  toJson() {
    return {
      'name': name,
      'description': description,
      'itemLabelName': itemLabelName,
      'visibility': visibility,
      'parentId': parentId,
      'properties': properties.map((e) => e.toJson()).toList(),
    };
  }
}