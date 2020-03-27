import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/cart_add_item.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ProductLoading extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ProductLoaded extends HomeEvent {
  final List<Product> products;
  const ProductLoaded({
    @required this.products,
  });

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'Product count { count: 5 }';
}

class AddItemCartButtPress extends HomeEvent {
  final CartAddItem item;

  AddItemCartButtPress(this.item);
  @override
  // TODO: implement props
  List<Object> get props => null;
}
