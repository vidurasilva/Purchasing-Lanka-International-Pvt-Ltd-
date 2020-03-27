import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/user.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;
  final User user;
  AuthenticationAuthenticated(this.token, this.user);
  @override
  List<Object> get props => [token, user];
  @override
  String toString() => '{ "token":"$token" ,"userme": "$user" }';
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationRegister extends AuthenticationState {}

class AuthenticationLogin extends AuthenticationState {}

class AuthenticationCart extends AuthenticationState {}

class AuthenticationAccessPrivileges extends AuthenticationState {}

class AuthenticationCodeForLogin extends AuthenticationState {
  final String token;
  AuthenticationCodeForLogin(this.token);
  @override
  List<Object> get props => [token];
  @override
  String toString() => '{ "token":"$token"}';
}
