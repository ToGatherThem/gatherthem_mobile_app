class ItemInfosModel {
  late String _label = "";
  late String _obtentionDate = "";

  set label(String value) {
    _label = value;
  }

  set obtentionDate(String value) {
    _obtentionDate = value;
  }

  toJson() {
    return {
      "label": _label,
      "obtentionDate": _obtentionDate,
    };
  }
}