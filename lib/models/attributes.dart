import 'package:purchasing_lanka_international/models/cart_add_item.dart';

class AttributesModel {
  String _name;
  Map<String, dynamic> _options;

  AttributesModel(this._name, this._options);

  static AttributesModel fromJson(Map<String, dynamic> json) {
    return AttributesModel(json['name'], json['options']);
  }
}
