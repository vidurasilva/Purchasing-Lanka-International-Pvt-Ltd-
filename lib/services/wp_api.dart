import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:purchasing_lanka_international/models/addres.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/models/country_best_customers.dart';
import 'package:purchasing_lanka_international/models/order_item_model.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://rk-eu.10it.lk/richkids/wp-json/';
//format of admin token is Bearer + token so don't delete 'Bearer' key word
const String adminToken =
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcmstZXUuMTBpdC5sa1wvcmljaGtpZHMiLCJpYXQiOjE1ODQwOTI0OTUsIm5iZiI6MTU4NDA5MjQ5NSwiZXhwIjoxNTg0Njk3Mjk1LCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxMzYifX19.y4vnVaovJXvJ8FImqrle8Jo04Ebl9QIwduh5Na_34Fo";

Future<String> getToken(username, password) async {
  var url = baseUrl + "jwt-auth/v1/token";
  http.Response response = await http.post(url, body: {
    "username": username,
    "password": password,
  });
  return response.body;
}

Future<String> newUserRequest(
    username, email, firstname, country, password) async {
  var url = baseUrl + "wp/v2/users";
  http.Response response = await http.post(url, headers: {
    "Authorization": adminToken,
  }, body: {
    "username": "$username",
    "email": "$email",
    "first_name": "$firstname",
    "country": "$country",
    "name": "$firstname",
    "password": "$password",
  });
  return response.body;
}

Future<String> userUpdateUsingCode(
    username, email, firstname, country, password) async {
  var url = baseUrl + "wp/v2/users";
  print("$username, $email, $firstname, $country, $password");
  http.Response response = await http.post(url, headers: {
    "Authorization": adminToken,
  }, body: {
    "username": "$username",
    "email": "$email",
    "first_name": "$firstname",
    "country": "$country",
    "name": "$firstname",
    "password": "$password",
    "roles": "customer",
  });
  return response.body;
}

Future<String> userCountryUpdate(country, userid) async {
  var url = baseUrl + "richkids/v1/user_country";
  http.Response response = await http.post(url, headers: {
    "Authorization": adminToken,
  }, body: {
    "countryname": country,
    "userid": "$userid",
  });
  return response.body;
}

Future<String> userCountryFlageUpdate(countryflage, userid) async {
  var url = baseUrl + "richkids/v1/user_country_flage";
  http.Response response = await http.post(url, headers: {
    "Authorization": adminToken,
  }, body: {
    "countryflage": countryflage,
    "userid": "$userid",
  });
  return response.body;
}

Future<String> receiptImageUplade(reciptImage, userId, filename) async {
  var url = baseUrl + "richkids/v1/upload_receipt";

  //convert image path to base64
  Uint8List bytes = Uint8List.fromList(File(reciptImage).readAsBytesSync());
  print(ByteData.view(bytes.buffer));
  String receiptBase64Image = base64Encode(bytes);
  // API calling
  Map data = {
    'filename': '$filename.jpg',
    'userid': '$userId',
    'image': '$receiptBase64Image',
  };
  var body = json.encode(data);
  http.Response response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": adminToken,
      },
      body: body);
  return response.body;
}

// get user detail from server
Future<User> getUser(token) async {
  var url = baseUrl + "wp/v2/users/me";
  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  print(response.body);
  return User.fromJson(jsonDecode(response.body));
}

// Product details  from product
Future<List<Product>> getProducts(token) async {
  var url = baseUrl + "wc/v3/products?per_page=99";

  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  try {
    Iterable prodListMap = jsonDecode(response.body);
    List<Product> prodList =
        List<Product>.from(prodListMap.map((i) => Product.fromJson(i)));
    // Product.map(Map model)=>Product.fromJson(prodListMap[1]).toList();
    return prodList;
  } catch (e) {
    return null;
  }
}

//user customer
Future<List<User>> getBestUsers(token) async {
  var url = baseUrl + "richkids/v1/users_customer";

  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  try {
    Iterable customerListMap = jsonDecode(response.body);
    List<User> customerList =
        List<User>.from(customerListMap.map((i) => User.fromJson(i)));
    return customerList;
  } catch (e) {
    return null;
  }
}

//get cart item
//get cart item value using cartitem.values
Future<List<ItemDetails>> getCartItems(token) async {
  var url = baseUrl + "wc/v2/cart";
  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  if (response.body.length < 20) {
    return null;
  } else {
    Map<String, dynamic> cartitem = jsonDecode(response.body);
    var cartlist = cartitem.values;
    List<ItemDetails> cartItemList =
        List<ItemDetails>.from(cartlist.map((i) => ItemDetails.fromJson(i)));
    print(cartItemList);
    return cartItemList;
  }
}

//add item to Item to Cart
Future<String> addItem(int id, int quantity, List variation, token) async {
  String ids = '$id';
  var jsonVariation;

  if (variation.length == 1) {
    jsonVariation = {
      "attribute_pa_${variation[0]['name'].toString()}": variation[0]['options']
          [0]
    };
  }
  if (variation.length == 2) {
    jsonVariation = {
      "attribute_pa_${variation[0]['name'].toString()}": variation[0]['options']
          [0],
      "attribute_pa_${variation[1]['name'].toString()}": variation[1]['options']
          [0]
    };
  }
  if (variation.length == 3) {
    jsonVariation = {
      "attribute_pa_${variation[0]['name'].toString()}": variation[0]['options']
          [0],
      "attribute_pa_${variation[1]['name'].toString()}": variation[1]['options']
          [0],
      "attribute_pa_${variation[2]['name'].toString()}": variation[2]['options']
          [0]
    };
  }
  if (variation.length == 4) {
    jsonVariation = {
      "attribute_pa_${variation[0]['name'].toString()}": variation[0]['options']
          [0],
      "attribute_pa_${variation[1]['name'].toString()}": variation[1]['options']
          [0],
      "attribute_pa_${variation[2]['name'].toString()}": variation[2]['options']
          [0],
      "attribute_pa_${variation[3]['name'].toString()}": variation[3]['options']
          [0]
    };
  }
  if (variation.length == 5) {
    jsonVariation = {
      "attribute_pa_${variation[0]['name'].toString()}": variation[0]['options']
          [0],
      "attribute_pa_${variation[1]['name'].toString()}": variation[1]['options']
          [0],
      "attribute_pa_${variation[2]['name'].toString()}": variation[2]['options']
          [0],
      "attribute_pa_${variation[3]['name'].toString()}": variation[3]['options']
          [0],
      "attribute_pa_${variation[4]['name'].toString()}": variation[4]['options']
          [0]
    };
  }

  // API calling
  Map data = {
    "product_id": ids,
    "quantity": quantity,
    "variation": jsonVariation
  };

  var body = json.encode(data);
  //Map<String, dynamic> jsonConverter = jsonDecode(jsonVariation);
  var url = baseUrl + "cocart/v1/add-item";
  http.Response response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body);
  return response.body;
}

//Deleate item from cart page
Future<String> deleteItem(guid, token) async {
  var url = baseUrl + "cocart/v1/item?cart_item_key=$guid";
  http.Response response = await http.delete(url, headers: {
    "Authorization": "Bearer $token",
  });
  return response.body;
}

//Deleate item from cart page
Future<String> clearAllCartItemOnce(token) async {
  var url = baseUrl + "cocart/v1/clear";
  http.Response response = await http.post(url, headers: {
    "Authorization": "Bearer $token",
  });
  return response.body;
}

//get total price for cart page
Future<String> getTotalPrice(token) async {
  var url = baseUrl + "cocart/v1/totals";
  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  Map<String, dynamic> prodListMap = jsonDecode(response.body);
  String tot = prodListMap['total'];
  return tot;
}

//Get  cart item count for cart page
Future<int> getCartItemsCount(token) async {
  var url = baseUrl + "cocart/v1/count-items";
  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  var itemacount = jsonDecode(response.body);

  return itemacount;
}

//add point to user
Future<String> addPointToUser(id, userPoint, token) async {
  String userId = '$id';
  String usersPoint = '$userPoint';
  var url = baseUrl + "richkids/v1/update_user_points";
  http.Response response = await http.post(url, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "userid": userId,
    "user_points": usersPoint,
  });
  return response.body;
}

//add Tip to user
Future<String> addTipsToUser(id, userTip, token) async {
  String userId = '$id';
  String usersTip = '$userTip';
  var url = baseUrl + "richkids/v1/update_user_tip";
  http.Response response = await http.post(url, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "userid": userId,
    "user_tip": usersTip,
  });
  return response.body;
}

//add total purchase to user
Future<String> addPurchaseValueToUser(id, userPurchase, token) async {
  String userId = '$id';
  String usersPurchase = '$userPurchase';
  var url = baseUrl + "richkids/v1/update_user_purchase";
  http.Response response = await http.post(url, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "userid": userId,
    "user_purchase": usersPurchase,
  });
  return response.body;
}

// get Best Customers form Country List sorting
Future<List<BestCustomersCountryModel>> getBestCustomersCountryList(
    token) async {
  var url = baseUrl + "richkids/v1/users_country_list";

  http.Response response = await http.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  Iterable countryListMap = jsonDecode(response.body);
  try {
    List<BestCustomersCountryModel> bestcountryList =
        List<BestCustomersCountryModel>.from(
            countryListMap.map((i) => BestCustomersCountryModel.fromJson(i)));
    // Product.map(Map model)=>Product.fromJson(prodListMap[1]).toList();
    return bestcountryList;
  } catch (e) {
    return null;
  }
}

//Get  cart item count for cart page
Future<String> createOrder(
    token, Addres userAddres, User user, List<ItemDetails> itemList) async {
  List orderitemList = new List<OrderItemModel>();
  for (var i = 0; i < itemList.length; i++) {
    OrderItemModel orderItem = new OrderItemModel(
        itemList[i].id, itemList[i].variationId, itemList[i].quantity);
    orderitemList.add(orderItem);
  }

  Map data = {
    "payment_method": "bacs",
    "payment_method_title": "Direct Bank Transfer",
    "set_paid": true,
    "billing": {
      "first_name": "${user.name}",
      "last_name": "${user.name}",
      "address_1": "${userAddres.address_1}",
      "address_2": "${userAddres.address_2}",
      "city": "${userAddres.city}",
      "state": "${userAddres.country}",
      "postcode": "${userAddres.postcode}",
      "country": "${userAddres.country}",
      "email": "${user.userEmail}",
      "phone": "(${userAddres.phone_number}"
    },
    "shipping": {
      "first_name": "${user.name}",
      "last_name": "${user.name}",
      "address_1": "${userAddres.address_1}",
      "address_2": "${userAddres.address_2}",
      "city": "${userAddres.city}",
      "state": "${userAddres.country}",
      "postcode": "${userAddres.postcode}",
      "country": "${userAddres.country}"
    },
    "line_items": orderitemList
  };

  var body = json.encode(data);
  var url = baseUrl + "wc/v1/orders";
  http.Response response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": adminToken,
      },
      body: body);
  return response.body;
}
