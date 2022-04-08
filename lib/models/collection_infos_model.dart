class CollectionInfosModel{
  late String _name = "";
  late String _description = "";

  set name(String value) {
    _name = value;
  }

  set description(String value) {
    _description = value;
  }

  toJson(){
    return {
      'name' : _name,
      'description' : _description,
    };
  }
}