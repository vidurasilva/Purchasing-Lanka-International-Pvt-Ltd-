import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_event.dart';
import 'package:purchasing_lanka_international/bloc/cart_state.dart';
import 'package:purchasing_lanka_international/models/addres.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/services/manege_cart_item.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc();
  @override
  CartState get initialState => CartLoadingState();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    String token = await getTokenFromPref();
    User user = await getUserFromPref();
    if (event is CartLoading) {
      // yield CartLoadingState();
//Api calling for get items and product
      List<ItemDetails> _cartItem = await getCartItems(token);

      if (_cartItem != null) {
        List<Product> _productList = await getProducts(token);
        ManegeCartProduct prod = new ManegeCartProduct(_productList, _cartItem);
        List<ItemDetails> items = prod.getFinalCartItem();
        String totalPrice = await getTotalPrice(token);

        yield CartLoadedState(items, totalPrice, user);
      } else {
        yield CartEmptyState();
      }
    }
    if (event is CartLoaded) {}
    if (event is AddItemButtonPressedInCart) {
      String token = await getTokenFromPref();
      String body = await addItem(
          event.item.id, event.item.quantity, event.item.variation, token);
      print(body);
    }

    if (event is CartItemDeleteButtonPressed) {
//Api Calling for delete item
      String code = await deleteItem(event.guid, token);
      print(code);
      yield CartLoadingState();
//Api calling for get items
      List<ItemDetails> _cartItem = await getCartItems(token);

      if (_cartItem != null) {
        List<Product> _productList = await getProducts(token);
        ManegeCartProduct prod = new ManegeCartProduct(_productList, _cartItem);
        List<ItemDetails> items = prod.getFinalCartItem();
        String totalPrice = await getTotalPrice(token);
        yield CartLoadedState(items, totalPrice, user);
      } else {
        yield CartEmptyState();
      }
    }

    if (event is ChechOutButtonPress) {
      // get variation
      Map<String, dynamic> variation = {
        "attribute_pa_color": "Green",
        "attribute_pa_point": "220"
      };
      //Api Calling for delete item
      for (var i = 0; i < event.itemList.length; i++) {
        if (event.itemList[i].variation.length > 0) {
          variation = event.itemList[i].variation;
        } else {
          //default point value is 100
          variation = {
            "attribute_pa_color": "red",
            "attribute_pa_point": "100"
          };
        }

        //varification Json decode

        String attributePoint = variation['attribute_pa_point'];
        int pointOfItem = int.parse(attributePoint);
        String userPoint = user.points;
        int pointOfUser = int.parse(userPoint);

        //collect total tips value and chech value
        String userTip = "0";
        if (user.tip != '') {
          userTip = user.tip;
        }
        //collect total Purchase value and chech value
        String userPurchase = "0";
        if (user.totalPurchase != '') {
          userPurchase = user.totalPurchase;
        }
        int totalTipValue = event.tipValue + int.parse(userTip);
        int totalPurchaseValue =
            event.itemList[i].price + int.parse(userPurchase);
        int sumOfPoint = pointOfUser + pointOfItem + (event.tipValue * 3);

        //API calling for add point to user
        String resultPointCode =
            await addPointToUser(user.id, sumOfPoint, token);
        print(resultPointCode);

        //API calling for add point to user
        String resultTipCode =
            await addTipsToUser(user.id, totalTipValue, token);
        print(resultTipCode);
        //API calling for add Purchase values to user
        String resultPurchaseCode =
            await addPurchaseValueToUser(user.id, totalPurchaseValue, token);
        print(resultPurchaseCode);
      }

      //Delete item after add point
      String clearAllCartItemOnceResult = await clearAllCartItemOnce(token);
      print(clearAllCartItemOnceResult);

      //get user me
      User userMe = await getUser(token);

      //set user for shaired preforances
      setUserToPref(jsonEncode(userMe));

      yield CartLoadingState();
      //Api calling for get items
      List<ItemDetails> _cartItem = await getCartItems(token);

      if (_cartItem != null) {
        List<Product> _productList = await getProducts(token);
        ManegeCartProduct prod = new ManegeCartProduct(_productList, _cartItem);
        List<ItemDetails> items = prod.getFinalCartItem();
        String totalPrice = await getTotalPrice(token);
        yield CartLoadedState(items, totalPrice, user);
      } else {
        yield CartEmptyState();
      }
      //Add Order item after add point
      Addres userAddres = new Addres('969 Market', 'Silvia Avn',
          'San Francisco', 'CA', '94103', user.country, '0342222999');
      String createOrderResult =
          await createOrder(token, userAddres, userMe, event.itemList);
      print(createOrderResult);
    }
  }
}
