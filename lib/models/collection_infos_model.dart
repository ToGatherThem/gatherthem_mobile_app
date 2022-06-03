import 'dart:developer';
import 'dart:typed_data';

class CollectionInfosModel{
  late String name = "";
  late String description = "";
  late String templateId = "";
  Uint8List? image;

  toJson() {
    return {
      'name': name,
      'description': description,
      'templateId': templateId,
      'image': image
    };
  }
}