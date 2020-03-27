import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_event.dart';
import 'package:purchasing_lanka_international/bloc/login_bloc.dart';
import 'package:purchasing_lanka_international/screens/auth_code/auth_code.dart';

class AuthHomePage extends StatelessWidget {
  AuthHomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocProvider(
            builder: (context) {
              return LoginBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
              );
            },
            child: AuthCodePage(),
          ),
          bottomNavigationBar: SizedBox(
              height: 60,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AccessToLoginRegister());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(RegisterUser());
                      },
                      child: Text(
                        'Request to Access',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
