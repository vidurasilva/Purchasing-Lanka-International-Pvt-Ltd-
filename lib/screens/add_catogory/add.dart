import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_event.dart';
import 'package:purchasing_lanka_international/screens/access_privilege/access_privilege.dart';
import 'package:purchasing_lanka_international/screens/auth_code/auth_code_home.dart';
import 'package:purchasing_lanka_international/screens/cart/cart_home_page.dart';
import 'package:purchasing_lanka_international/screens/loading/loading.dart';
import 'package:purchasing_lanka_international/screens/login/login_page.dart';
import 'package:purchasing_lanka_international/screens/request_access/request_access_home_page.dart';
import 'package:purchasing_lanka_international/screens/sign_up/sign_up.dart';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import '../landing_page.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppBlocInit(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text('Today Special',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Apple',
                          fontSize: 20.0,
                          decoration: TextDecoration.none)),
                ),
              ),
              Expanded(
                flex: 7,
                child: Image.asset('assets/adds/sampath_foodcity.jpg'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppBlocInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc()..add(AppStarted());
      },
      child: gotoLogin(),
    ));
  }

  Widget gotoLogin() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationUninitialized) {
          String imagepath = 'assets/backgrounds/splash.png';
          return LoadingIndicator();
        }
        if (state is AuthenticationAuthenticated) {
          return BlocProvider<NavBloc>(
            builder: (context) {
              return NavBloc()..add(NavStart());
            },
            child: LandingPage(),
          );
        }
        if (state is AuthenticationAccessPrivileges) {
          return AccessPrivilege();
        }
        if (state is AuthenticationUnauthenticated) {
          return AuthHomePage();
        }
        if (state is AuthenticationRegister) {
          return RequestAccessHome();
        }
        if (state is AuthenticationLogin) {
          return LoginPage();
        }
        if (state is AuthenticationLoading) {
          String imagepath = 'assets/backgrounds/splash.png';
          return LoadingIndicator();
        }
        if (state is AuthenticationCart) {
          return CartHomePage();
        }
        if (state is AuthenticationCodeForLogin) {
          String token = state.token;
          //return SignUpHome();
          return Scaffold(
            body: BlocProvider(
              builder: (context) {
                return RequestAccessBloc(
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context),
                );
              },
              child: SignUpPage(token),
            ),
          );
        }
      },
    );
  }
}
