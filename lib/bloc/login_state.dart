import 'package:purchasing_lanka_international/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  // final Userme;
  @override
  String toString() => 'Logged user';
}

class LoginLoading extends LoginState {}

class LoginWithCode extends LoginState {
  final String strToken;
  LoginWithCode(@required this.strToken);
  @override
  List<Object> get props => [strToken];

  @override
  String toString() => 'Token use for update user detail { token: $strToken }';
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
