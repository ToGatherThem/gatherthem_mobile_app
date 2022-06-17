class PropertyCreationModel {
  late String name = "";
  late String type = "TEXT";

  toJson() {
    return {
      'name': name,
      'type': type
    };
  }
}