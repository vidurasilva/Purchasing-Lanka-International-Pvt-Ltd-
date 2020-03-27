import 'package:flutter/material.dart';
import 'package:purchasing_lanka_international/screens/add_catogory/add.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPage(),
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
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 90),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Welcome to the world's\n",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Apple',
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                                text: "most exclusive game\n",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Apple',
                                    fontSize: 20.0,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                                text: 'By invite only',
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontFamily: 'Apple',
                                    fontSize: 12.0,
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Image.asset('assets/backgrounds/splash.png'),
              )
            ],
          )
        ],
      ),
    );
  }
}
