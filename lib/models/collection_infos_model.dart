class CollectionInfosModel{
  late String _type;
  late String _name;
  late String _description;

  set type(String value) {
    _type = value;
  }

  set name(String value) {
    _name = value;
  }

  set description(String value) {
    _description = value;
  }

  toJson(){
    return {
      'type' : _type,
      'name' : _name,
      'description' : _description,
    };
  }
}