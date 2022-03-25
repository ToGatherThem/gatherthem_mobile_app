class CollectionInfosModel{
  late String _type;
  late String _name;
  late String _description;
  late num _creationDate;

  set type(String value) {
    _type = value;
  }

  set name(String value) {
    _name = value;
  }

  set description(String value) {
    _description = value;
  }

  set creationDate(num value) {
    _creationDate = value;
  }

  toJson(){
    return {
      'type' : _type,
      'name' : _name,
      'description' : _description,
      'creationDate' : _creationDate
    };
  }
}