class ItemDetails {
  final _key;
  final _id;
  String _name;
  final _variationId;
  int _price;
  int _quantity;
  Map<String, dynamic> _variation;
  String image_path;

  ItemDetails(this._key, this._id, this._name, this._variationId, this._price,
      this._quantity, this._variation);
  String get key => _key;
  int get id => _id;
  String get name => _name;
  int get variationId => _variationId;
  int get price => _price;
  int get quantity => _quantity;
  Map<String, dynamic> get variation => _variation;

  Map<String, dynamic> toJson() => {
        'key': key,
        'product_id': id,
        'product_name': name,
        "variation_id": variationId,
        'line_total': price,
        'quantity': quantity,
        'variation': variation,
      };

//String temp = json['images'].toString();

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      json['key'],
      json['product_id'],
      json['product_name'],
      json['variation_id'],
      json['line_total'],
      json['quantity'],
      json['variation'],
    );
  }
  @override
  String toString() {
    return '{ ${this._id},${this._name},${this._variationId}, ${this._key},${this._price},$variation }';
  }
}
