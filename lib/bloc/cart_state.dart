import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartEmptyState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  final List<ItemDetails> items;
  final String totalPrice;
  final User user;

  CartLoadedState(
    this.items,
    this.totalPrice,
    this.user,
  );
  @override
  List<Object> get props => [items, totalPrice, user];
  @override
  String toString() => '{ "count: 1"}';
}

class CartError extends CartState {
  @override
  List<Object> get props => [];
}
