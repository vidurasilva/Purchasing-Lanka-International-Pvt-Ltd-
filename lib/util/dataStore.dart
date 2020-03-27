import 'dart:convert';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getTokenFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

void setTokenToPref(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

Future<User> getUserFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userjson = prefs.getString('userjson');
  if (userjson == null || userjson == 'null') {
    return null;
  }
  try {
    return User.fromJson(jsonDecode(userjson));
  } on FormatException catch (e) {
    return null;
  }
}

void setUserToPref(String user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userjson', user);
}

clearUserTokenPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("user");
  prefs.remove("token");
}

void setReceiptImageToPref(reciptImage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('reciptImage', reciptImage);
}

Future<String> getReceiptImageFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('reciptImage');
}
