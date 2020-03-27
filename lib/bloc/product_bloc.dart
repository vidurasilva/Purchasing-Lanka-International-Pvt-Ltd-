import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/product_state.dart';
import 'package:purchasing_lanka_international/bloc/product_event.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/services/manege_product.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'product_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc();
  @override
  HomeState get initialState => ProductLoadingState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    String token = await getTokenFromPref();
    if (event is ProductLoading) {
      List<Product> products = await getProducts(token);
      if (products == null) {
        yield ProductLoadingFailure(error: 'error');
      } else {
        User user = await getUserFromPref();
        int points = int.parse(user.points);
        print(points);
        int itemCount = await getCartItemsCount(token);
        //Api calling for get items
        List<ItemDetails> cartItem = await getCartItems(token);
        if (cartItem == null) {
          cartItem = [];
        }
        ManegeProduct productLevel =
            new ManegeProduct(products, cartItem, points);
        List<List<Product>> probList = productLevel.getLevels();
        yield ProductLoadedState(probList, user, itemCount);
      }
    }
    if (event is AddItemCartButtPress) {
      String body = await addItem(
          event.item.id, event.item.quantity, event.item.variation, token);
      print(body);
      yield ProductLoadingState();
    }
  }
}
