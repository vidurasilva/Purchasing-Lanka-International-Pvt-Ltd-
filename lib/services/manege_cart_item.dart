import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/product.dart';

class ManegeCartProduct {
  List<Product> _productList;
  List<ItemDetails> _cartItem;

  ManegeCartProduct(this._productList, this._cartItem);

  List<Product> get productLevelList => _productList;
  List<ItemDetails> get itemImageAdd => _cartItem;
  List<ItemDetails> getFinalCartItem() {
    //for loop .prodLists
    // create new list for level
    //add new
    for (var i = 0; i < _productList.length; i++) {
      for (var j = 0; j < _cartItem.length; j++) {
        if (_productList[i].id == _cartItem[j].id) {
          _cartItem[j].image_path = _productList[i].images[0].src;
        }
      }
    }
    return _cartItem;
  }
}
