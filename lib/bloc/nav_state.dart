import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/product.dart';

abstract class NavState extends Equatable {
  const NavState();

  @override
  List<Object> get props => [];
}

class NavLoadingState extends NavState {
  @override
  String toString() => 'Logged user';
}

class HomeState extends NavState {
  String categori;
  HomeState(this.categori);

  @override
  String toString() => 'Logged user';
}

class CatogoryState extends NavState {
  @override
  String toString() => 'Logged user';
}

class CartState extends NavState {
  @override
  String toString() => 'Logged user';
}

class UserProfileState extends NavState {
  @override
  String toString() => 'Logged user';
}

class ShowProducts extends NavState {
  ShowProducts(Product product);
}

class ScoreBoardState extends NavState {}
