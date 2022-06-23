class ItemPropertyCreationModel {
  String id;
  String propertyId;
  String value;

  ItemPropertyCreationModel(this.id, this.propertyId, this.value);

  toJson() {
    return {
      "id" : id,
      "propertyId": propertyId,
      "value": value
    };
  }
}