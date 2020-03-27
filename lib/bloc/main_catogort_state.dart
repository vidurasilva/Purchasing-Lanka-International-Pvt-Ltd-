import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:purchasing_lanka_international/models/user.dart';

abstract class MainCatogoryState extends Equatable {
  const MainCatogoryState();
  @override
  List<Object> get props => [];
}

class MainCatogoryLoadingState extends MainCatogoryState {
  @override
  String toString() => 'null';
}

class MainCatogoryLoadedState extends MainCatogoryState {
  final List<List<Product>> products;
  final User user;
  int itemCount;

  MainCatogoryLoadedState(this.products, this.user, this.itemCount);
  @override
  List<Object> get props => [products, user, itemCount];
  @override
  String toString() => '{ "count: 1"}';
}
