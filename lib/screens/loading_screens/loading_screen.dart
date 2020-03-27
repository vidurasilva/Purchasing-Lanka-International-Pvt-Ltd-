import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_event.dart';
import 'package:purchasing_lanka_international/bloc/request_access_state.dart';

class LoadingScreen extends StatefulWidget {
  String username;
  String firstname;
  String email;
  String password;
  String country;
  String countryFlag;
  String token;

  LoadingScreen(this.username, this.firstname, this.email, this.password,
      this.country, this.countryFlag, this.token);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {}

    return BlocListener<RequestAccessBloc, RequestAccessState>(
      listener: (context, state) {},
      child: BlocBuilder<RequestAccessBloc, RequestAccessState>(
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: <Widget>[
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Congratulations\n\n",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Apple',
                                        fontSize: 20.0)),
                                TextSpan(
                                    text:
                                        "You are now part of the world’s most exclusive game. Here you will get access to unique goods and services, and be able to compete with a chosen few. Show your wealth, get rewarded and at end, a very special prize awaits. Time is of the essence. Good luck.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Apple',
                                        fontSize: 14.0)),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: Image.asset('assets/backgrounds/splash.png'),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<RequestAccessBloc>(context).add(
                            PressRulesScreen(
                                firstname: widget.firstname,
                                username: widget.username,
                                email: widget.email,
                                password: widget.password,
                                country: widget.country,
                                countryFlag: widget.countryFlag,
                                token: widget.token));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border:
                              Border.all(width: 2, color: Colors.amberAccent),
                        ),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(90 / 360),
                          child: Icon(
                            (Icons.navigation),
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
