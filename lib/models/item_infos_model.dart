class ItemInfosModel {
  late String _label = "";

  set label(String value) {
    _label = value;
  }

  toJson() {
    return {
      "label": _label,
    };
  }
}