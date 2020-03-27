import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:purchasing_lanka_international/models/product.dart';

abstract class MainCatogoryEvent extends Equatable {
  const MainCatogoryEvent();
}

class ProductLoading extends MainCatogoryEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ProductLoaded extends MainCatogoryEvent {
  final List<Product> products;
  const ProductLoaded({
    @required this.products,
  });

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'Product count { count: 5 }';
}
