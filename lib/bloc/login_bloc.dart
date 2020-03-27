import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final HomeBloc homePassTokenUser;

  LoginBloc({@required this.authenticationBloc, this.homePassTokenUser})
      : assert(authenticationBloc != null, homePassTokenUser != null);

  LoginState get initialState => LoginInitial();

  BuildContext get context => null;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        //get token
        String strTok = await getToken(event.username, event.password);

        //Decode the Jsone file and assign data to veriable
        Map<String, dynamic> mapToken = jsonDecode(strTok);
        var token = mapToken["token"];

        //get user me
        User user = await getUser(token);

        //chech about token is null or not
        if (token == null) {
          if (mapToken['code'] == '[jwt_auth] empty_username') {
            throw ('empty username'); // throw username empty
          }
          if (mapToken['code'] == '[jwt_auth] empty_password') {
            throw ('empty password'); // throw password empty
          }
          if (mapToken['code'] == '[jwt_auth] invalid_username') {
            throw ('invalid username'); // throw username error
          } else {
            throw ('incorrect password'); // throw password error
          }
        } else {
          authenticationBloc.add(LoggedIn(token: token, user: user));
          print(user.id);
          // homePassTokenUser.add(ProdcuctLoaded(token: token , user: user));
          print(user.id);
          yield LoginInitial();
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is EnterCodeButtonPressed) {
      yield LoginLoading();
      try {
        //get token
        String strTok = await getToken(event.username, event.password);

        //Decode the Jsone file and assign data to veriable
        Map<String, dynamic> mapToken = jsonDecode(strTok);
        var token = mapToken["token"];
        //chech about token is null or not
        if (token == null) {
          authenticationBloc.add(LoggedOut());
          if (mapToken['code'] == '[jwt_auth] invalid_username') {
            throw ('invalid username'); // throw username error
          } else {
            throw ('incorrect password'); // throw password error
          }
        } else {
          authenticationBloc.add(AccessCodeForLogin(token: token));
          yield LoginWithCode(token);
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
