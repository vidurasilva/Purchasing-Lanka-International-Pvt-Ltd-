import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

abstract class RequestAccessState extends Equatable {
  const RequestAccessState();
  @override
  List<Object> get props => [];
}

class RequestingState extends RequestAccessState {}

class RequestInitial extends RequestAccessState {}

class RequestedState extends RequestAccessState {}

class ImageUploadedState extends RequestAccessState {}

class UploadingImageState extends RequestAccessFailure {
  final String imagePath;

  const UploadingImageState(this.imagePath);
  @override
  List<Object> get props => [imagePath];

  @override
  String toString() => 'Image Path { imagepath: $imagePath }';
}

class RequestAccessFailure extends RequestAccessState {
  final String error;

  const RequestAccessFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class PressLoadingScreenState extends RequestAccessState {
  final String username;
  final String email;
  final String firstname;
  final String country;
  final String countryFlag;
  final String password;
  final String token;
  PressLoadingScreenState({
    @required this.firstname,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.country,
    @required this.countryFlag,
    @required this.token,
  });
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'PressLoadingScreenState { username:$username, email:$email, firstname:$firstname, password:$password, country:$country, countryflage:$countryFlag}';
}

class PressRulescreenState extends RequestAccessState {
  final String username;
  final String email;
  final String firstname;
  final String country;
  final String countryFlag;
  final String password;
  final String token;
  PressRulescreenState({
    @required this.firstname,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.country,
    @required this.countryFlag,
    @required this.token,
  });
  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'PressRulescreenState { username:$username, email:$email, firstname:$firstname, password:$password, country:$country, countryflage:$countryFlag}';
}
