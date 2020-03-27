import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_event.dart';
import 'package:purchasing_lanka_international/bloc/request_access_state.dart';

class Rules extends StatefulWidget {
  String username;
  String firstname;
  String email;
  String password;
  String country;
  String countryFlag;
  String token;

  Rules(this.username, this.firstname, this.email, this.password, this.country,
      this.countryFlag, this.token);
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {}

    return BlocListener<RequestAccessBloc, RequestAccessState>(
      listener: (context, state) {},
      child: BlocBuilder<RequestAccessBloc, RequestAccessState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: <Widget>[
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Rules of the game\n\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Apple',
                                      fontSize: 20.0)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "1. The goal of the game is to reach the final 6th level. \n 2. Access to higher levels can be reached through reaching the required amount of points. \n 3. Points can be acquired through products and experiences. \n Keep your eyes open. Solving hints and clues from level 3 and onwards is required to \n 4. ___________ \n 5. ___________",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Apple',
                                        fontSize: 14.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Image.asset('assets/backgrounds/rules.png'),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<RequestAccessBloc>(context).add(
                            PressUpdateUser(
                                firstname: widget.firstname,
                                username: widget.username,
                                email: widget.email,
                                password: widget.password,
                                country: widget.country,
                                countryFlag: widget.countryFlag,
                                token: widget.token));
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              Future.delayed(Duration(seconds: 6), () {
                                Navigator.of(context).pop(true);
                              });
                              return Center(
                                child: new SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: new CircularProgressIndicator(
                                      value: null,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.amber)),
                                ),
                              );
                            });
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
