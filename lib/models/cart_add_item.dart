import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:purchasing_lanka_international/models/attributes.dart';

@immutable
class CartAddItem extends Equatable {
  final int _id;
  final int _quantity;
  final _variation;

  CartAddItem(this._id, this._quantity, this._variation);

  int get id => _id;
  int get quantity => _quantity;
  get variation => _variation;

  Map<String, dynamic> toJson() => {
        'product_id': id,
        'quantity': quantity,
        'attributes': variation,
      };

//String temp = json['images'].toString();

  factory CartAddItem.fromJson(Map<String, dynamic> json) {
    return CartAddItem(
      json['product_id'],
      json['quantity'],
      (json['attributes'] as List).map((i) {
        return AttributesModel.fromJson(i);
      }).toList(),
    );
  }
  @override
  String toString() {
    return '{ ${this.id}, ${this._quantity} ,${this._variation}}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
