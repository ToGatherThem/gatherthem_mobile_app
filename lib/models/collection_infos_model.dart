class CollectionInfosModel{
  late String name = "";
  late String description = "";
  late String templateId = "";

  toJson() {
    return {
      'name': name,
      'description': description,
      'templateId': templateId,
    };
  }
}