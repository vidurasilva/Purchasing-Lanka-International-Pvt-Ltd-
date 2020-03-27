import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final String token = await getTokenFromPref();
      final User user = await getUserFromPref();

      if (token != null && user != null) {
        yield AuthenticationAuthenticated(token, user);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      //set token in local storage
      setTokenToPref(event.token);
      setUserToPref(jsonEncode(event.user));

      var subscriber = event.user.role[0] as String;

      if (subscriber == "subscriber") {
        yield AuthenticationAccessPrivileges();
        print('AuthenticationAccessPrivileges');
      } else {
        yield AuthenticationAuthenticated(event.token, event.user);
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      //clear user/ token
      clearUserTokenPref();
      yield AuthenticationUnauthenticated();
    }

    if (event is RegisterUser) {
      yield AuthenticationRegister();
    }
    if (event is AccessToLoginRegister) {
      yield AuthenticationLogin();
    }
    if (event is AccessCodeForLogin) {
      String token = event.token;
      yield AuthenticationCodeForLogin(token);
    }
  }
}
