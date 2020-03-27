import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/product.dart';

class ManegeProduct {
  List<Product> _productList;
  List<ItemDetails> _cartItem;
  int _userPoints;

  ManegeProduct(this._productList, this._cartItem, this._userPoints);

  List<Product> get productLevelList => _productList;
  List definedLevel = ['Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5'];
  List<List<Product>> newProdList;
  List<List<Product>> getLevels() {
    //for loop .prodLists
    // create new list for level

    List<List<Product>> prodLists = new List<List<Product>>();
    //add new
    for (var i = 0; i < definedLevel.length; i++) {
      List<Product> levelList = new List<Product>();

      for (var j = 0; j < _productList.length; j++) {
        if (definedLevel[i] == _productList[j].categories[0].name) {
          levelList.add(_productList[j]);
        }
      }
      if (levelList.length >= 1) {
        prodLists.add(levelList);
      }
    }
    //set visibality true using user point
    if (_userPoints < 500) {
      newProdList = setLevelVisibility(1, prodLists, _cartItem);
    }
    //set visibality true using user point
    if (500 < _userPoints && _userPoints < 1001) {
      newProdList = setLevelVisibility(2, prodLists, _cartItem);
    }
    //set visibality true using user point
    if (1000 < _userPoints && _userPoints <= 1500) {
      newProdList = setLevelVisibility(3, prodLists, _cartItem);
    }
    //set visibality true using user point
    if (1500 < _userPoints && _userPoints <= 2000) {
      newProdList = setLevelVisibility(4, prodLists, _cartItem);
    }
    if (2000 < _userPoints) {
      newProdList = setLevelVisibility(5, prodLists, _cartItem);
    }

    return prodLists;
  }

  List<List<Product>> setLevelVisibility(int levelValue,
      List<List<Product>> prodLists, List<ItemDetails> cartItem) {
    List<Product> levelList = new List<Product>();
    List<List<Product>> newProdLists = new List<List<Product>>();

    for (var i = 0; i < prodLists.length; i++) {
      List<Product> newProductList = new List<Product>();
      if (i < levelValue) {
        levelList = prodLists[i];
        for (var j = 0; j < levelList.length; j++) {
          print(levelList[j].isVisible);
          levelList[j].isVisible = true;
          print(levelList[j].isVisible);
          print("****************************$j");
          if (cartItem.length > 0) {
            for (var k = 0; k < cartItem.length; k++) {
              if (levelList[j].name == cartItem[k].name) {
                levelList[j].inCart = true;
                levelList[j].cartItemCount = cartItem[k].quantity;
              }
            }
          }

          newProductList.add(levelList[j]);
        }
        newProdLists.add(newProductList);
      } else {
        newProdLists.add(prodLists[i]);
      }
    }

    return newProdLists;
  }
}
