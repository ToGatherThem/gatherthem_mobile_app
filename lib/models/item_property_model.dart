
import 'package:gatherthem_mobile_app/models/property_model.dart';

class ItemPropertyModel{
  String id;
  String value;
  PropertyModel property;

  ItemPropertyModel.fromJson(Map<String, dynamic> json):
    id = json['id'],
    value = json['value'],
    property = PropertyModel.fromJson(json['property']);
}