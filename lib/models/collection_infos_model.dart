class CollectionInfosModel{
  late String name = "";
  late String description = "";

  toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}