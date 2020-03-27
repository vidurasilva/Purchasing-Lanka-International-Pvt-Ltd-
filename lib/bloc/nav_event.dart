import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/cart_add_item.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/product.dart';

abstract class NavEvent extends Equatable {
  const NavEvent();
}

class NavStart extends NavEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GoToCartButtonPressedNav extends NavEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GoToHomeButtonPressedNav extends NavEvent {
  String categori;
  GoToHomeButtonPressedNav(this.categori);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GoToCatogoryButtonPressedNav extends NavEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GoToScoreBoadrButtonPressedNav extends NavEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GoToUserProfileButtonPressedNav extends NavEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetProductDetails extends NavEvent {
  Product showDetailsproduct;

  GetProductDetails(Product product);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AddItemButtonPressed extends NavEvent {
  final CartAddItem item;

  const AddItemButtonPressed(this.item);

  @override
  List<Object> get props => [item];
  @override
  String toString() => 'AddItemButtonPressed { ItemDetails: $item }';
}
