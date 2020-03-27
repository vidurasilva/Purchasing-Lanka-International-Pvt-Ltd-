class OrderItemModel {
  final productid;
  final variationid;
  final quantity;

  OrderItemModel(
    this.productid,
    this.variationid,
    this.quantity,
  );
  Map toJson() => {
        'product_id': productid,
        'variation_id': variationid,
        "quantity": quantity,
      };
}
