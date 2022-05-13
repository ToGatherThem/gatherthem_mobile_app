class ItemPropertyCreationModel {
  String propertyId;
  String value;

  ItemPropertyCreationModel(this.propertyId, this.value);

  toJson() {
    return {
      "propertyId": propertyId,
      "value": value
    };
  }
}