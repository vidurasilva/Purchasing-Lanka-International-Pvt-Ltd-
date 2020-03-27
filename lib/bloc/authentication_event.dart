import 'package:purchasing_lanka_international/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final User user;
  const LoggedIn({@required this.token, @required this.user});

  @override
  List<Object> get props => [token, user];

  @override
  String toString() => 'LoggedIn { token: $token userModel: $user }';
}

class LoggedOut extends AuthenticationEvent {}

class RegisterUser extends AuthenticationEvent {}

class AccessToLoginRegister extends AuthenticationEvent {}

class AccessCodeForLogin extends AuthenticationEvent {
  final String token;

  const AccessCodeForLogin({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedWithCode { token: $token}';
}
