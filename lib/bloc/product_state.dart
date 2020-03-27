import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends HomeState {
  @override
  String toString() => 'null';
}

class ProductLoadedState extends HomeState {
  final List<List<Product>> products;
  final User user;
  int itemCount;

  ProductLoadedState(this.products, this.user, this.itemCount);
  @override
  List<Object> get props => [products, user, itemCount];
  @override
  String toString() => '{ "count: 1"}';
}

class ProductLoadingFailure extends HomeState {
  final String error;
  ProductLoadingFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProductLodingFailure { error: $error }';
}
