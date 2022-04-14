class ItemInfosModel {
  late String label = "";
  late String obtentionDate = "";

  toJson() {
    return {
      "label": label,
      "obtentionDate": obtentionDate,
    };
  }
}