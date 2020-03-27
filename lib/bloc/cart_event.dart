import 'package:equatable/equatable.dart';
import 'package:flutter/src/services/text_input.dart';
import 'package:purchasing_lanka_international/models/cart_add_item.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartLoaded extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartItemDeleteButtonPressed extends CartEvent {
  final String guid;

  const CartItemDeleteButtonPressed(this.guid);

  @override
  List<Object> get props => [guid];
  @override
  String toString() => 'CartItemDeleteButtonPressed { ItemDetails: $guid }';
}

class AddItemButtonPressedInCart extends CartEvent {
  final CartAddItem item;

  const AddItemButtonPressedInCart(this.item);

  @override
  List<Object> get props => [item];
  @override
  String toString() => 'AddItemButtonPressed { ItemDetails: $item }';
}

class ChechOutButtonPress extends CartEvent {
  final List<ItemDetails> itemList;
  final String points;
  final int tipValue;
  ChechOutButtonPress(this.itemList, this.points, this.tipValue);

  @override
  List<Object> get props => [itemList, points, tipValue];
  @override
  String toString() =>
      'CartItemDeleteButtonPressed { ItemDetails:$itemList Points:$points TipValue:$tipValue }';
}
