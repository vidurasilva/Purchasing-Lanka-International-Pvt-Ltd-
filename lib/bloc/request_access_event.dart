import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/bloc/authentication_event.dart';
import 'package:meta/meta.dart';

abstract class RequestAccessEvent extends Equatable {
  const RequestAccessEvent();

  add(RegisterUser registerUser) {}
}

class PressRequestingAccess extends RequestAccessEvent {
  final String username;
  final String email;
  final String firstname;
  final String country;
  final String countryFlag;
  final String password;

  const PressRequestingAccess({
    @required this.firstname,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.country,
    @required this.countryFlag,
  });

  @override
  List<Object> get props =>
      [username, email, firstname, country, countryFlag, password];

  @override
  String toString() =>
      'PressRequestingAccess { fullname:$firstname,country:$country,countryFlag:$countryFlag, usernames: $username, email: $email, password: $password, }';
}

class UploadImage extends RequestAccessEvent {
  final String receiptImage;
  final int id;
  final String username;
  UploadImage(this.receiptImage, this.id, this.username);

  @override
  List<Object> get props => [receiptImage, id, username];
}

class UplodingImage extends RequestAccessEvent {
  final String imagePath;
  UplodingImage(this.imagePath);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PressLoadingScreen extends RequestAccessEvent {
  final String username;
  final String email;
  final String firstname;
  final String country;
  final String countryFlag;
  final String password;
  final String token;

  const PressLoadingScreen({
    @required this.firstname,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.country,
    @required this.countryFlag,
    @required this.token,
  });

  @override
  List<Object> get props =>
      [username, email, firstname, country, countryFlag, password, token];

  @override
  String toString() =>
      'PressLoadingScreen { fullname:$firstname,country:$country,countryFlag:$countryFlag, usernames: $username, email: $email, password: $password, token:$token}';
}

class PressRulesScreen extends RequestAccessEvent {
  final String username;
  final String email;
  final String firstname;
  final String country;
  final String countryFlag;
  final String password;
  final String token;

  const PressRulesScreen({
    @required this.firstname,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.country,
    @required this.countryFlag,
    @required this.token,
  });

  @override
  List<Object> get props =>
      [username, email, firstname, country, countryFlag, password, token];

  @override
  String toString() =>
      'PressRulesScreen { fullname:$firstname,country:$country,countryFlag:$countryFlag, usernames: $username, email: $email, password: $password, token:$token}';
}

class PressUpdateUser extends RequestAccessEvent {
  final String username;
  final String email;
  final String firstname;
  final String country;
  final String countryFlag;
  final String password;
  final String token;

  const PressUpdateUser({
    @required this.firstname,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.country,
    @required this.countryFlag,
    @required this.token,
  });

  @override
  List<Object> get props =>
      [username, email, firstname, country, countryFlag, password, token];

  @override
  String toString() =>
      'PressUpdateUser { fullname:$firstname,country:$country,countryFlag:$countryFlag, usernames: $username, email: $email, password: $password, token:$token}';
}
