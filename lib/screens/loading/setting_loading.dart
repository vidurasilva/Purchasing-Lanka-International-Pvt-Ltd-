import 'package:flutter/material.dart';

class UserProfileLoadingPage extends StatefulWidget {
  @override
  _UserProfileLoadingPageState createState() => _UserProfileLoadingPageState();
}

class _UserProfileLoadingPageState extends State<UserProfileLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'Settings',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
              ),
            )),
        body: Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  //get data
                  style: TextStyle(
                      color: Colors.black, fontSize: 19.0, fontFamily: 'Lato'),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 22.0),
                    labelText: 'Nick Name',
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black54,
                        fontSize: 14.0,
                        height:
                            -5.0, //to center the input text between lable and inputborder
                        letterSpacing: 3),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  //get data
                  style: TextStyle(
                      color: Colors.black, fontSize: 19.0, fontFamily: 'Lato'),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 22.0),
                    labelText: 'User Name',
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black54,
                        fontSize: 14.0,
                        height: -5.0,
                        letterSpacing: 3),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  //get data
                  style: TextStyle(
                      color: Colors.black, fontSize: 19.0, fontFamily: 'Lato'),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 22.0),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black54,
                        fontSize: 14.0,
                        height: -5.0,
                        letterSpacing: 3),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  //get data
                  style: TextStyle(
                      color: Colors.black, fontSize: 19.0, fontFamily: 'Lato'),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 22.0),
                    labelText: 'Country',
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black54,
                        fontSize: 14.0,
                        height: -5.0,
                        letterSpacing: 3),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Align(
                    alignment: Alignment.center,
                    child: ButtonTheme(
                      height: 40,
                      minWidth: 340,
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        // textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(color: Colors.black54),
                        ),
                        child: Text(
                          'CONTACT US',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Georgia',
                              fontSize: 14.0),
                        ),
                        onPressed: () {
                          // BlocProvider.of<AuthenticationBloc>(context)
                          //     .add(LoggedOut());
                          //contact function
                          //valifation
                        },
                      ),
                    )),
                ButtonTheme(
                  height: 40,
                  minWidth: 340,
                  child: FlatButton(
                    color: Colors.black87,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Georgia',
                          fontSize: 14.0),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
