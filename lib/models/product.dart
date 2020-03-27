import 'package:purchasing_lanka_international/models/image.dart';
import 'categories_model.dart';

class Product {
  final _id;
  final _price;
  String _name;
  List<CategoriesModel> _categories;
  List<ImageModel> _images = [];
  List _attributes;
  List _defaultAttributes;
  String _description = 'best data';
  bool isVisible = false;
  bool inCart = false;
  int cartItemCount = 0;

  Product(this._id, this._price, this._name, this._categories, this._images,
      this._attributes, this._defaultAttributes, this._description);
  int get id => _id;
  String get name => _name;
  String get price => _price;
  List<CategoriesModel> get categories => _categories;
  List<ImageModel> get images => _images;
  List get attributes => _attributes;
  List get defaultAttributes => _defaultAttributes;
  String get description => _description;

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'name': name,
        'categories': categories,
        'images': images,
        'attributes': attributes,
        'default_attributes': defaultAttributes,
        'description': description,
      };

//String temp = json['images'].toString();CategoriesModel

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['price'],
      json['name'],
      (json['categories'] as List).map((i) {
        return CategoriesModel.fromJson(i);
      }).toList(),
      (json['images'] as List).map((i) {
        return ImageModel.fromJson(i);
      }).toList(),
      json['attributes'],
      json['default_attributes'],
      json['description'],
    );
  }
}
