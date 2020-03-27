import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/profile_bloc.dart';
import 'package:purchasing_lanka_international/bloc/profile_state.dart';
import 'package:purchasing_lanka_international/screens/loading/loading.dart';
import 'package:purchasing_lanka_international/screens/loading/setting_loading.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController _nickNameController = TextEditingController();

  TextEditingController _firstNameController = TextEditingController();

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          TextEditingController _nickNameController = TextEditingController();
          String nickName; //nickname input

          TextEditingController _firstNameController = TextEditingController();
          String firstkName; //firstname input

          TextEditingController _emailController = TextEditingController();
          String email; //nickname input

          TextEditingController _countryController = TextEditingController();
          String country;

          if (state is ProfileLoadingState) {
            // String imagepath = 'assets/backgrounds/blur_profile.jpg';
            // return LoadingIndicator(imagepath);
            return UserProfileLoadingPage();
          }
          if (state is ProfileLoadedState) {
            User user = state.user;
            nickName = user.slug;
            firstkName = user.name;
            email = user.userEmail;
            country = user.country;

            _nickNameController.text = nickName;
            _firstNameController.text = firstkName;
            _emailController.text = email;
            _countryController.text = country;
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
                          controller: _firstNameController, //get data
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontFamily: 'Lato'),
                          decoration: InputDecoration(
                            contentPadding:
                                new EdgeInsets.symmetric(vertical: 22.0),
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
                          controller: _nickNameController, //get data
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontFamily: 'Lato'),
                          decoration: InputDecoration(
                            contentPadding:
                                new EdgeInsets.symmetric(vertical: 22.0),
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
                          controller: _emailController, //get data
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontFamily: 'Lato'),
                          decoration: InputDecoration(
                            contentPadding:
                                new EdgeInsets.symmetric(vertical: 22.0),
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
                          controller: _countryController, //get data
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontFamily: 'Lato'),
                          decoration: InputDecoration(
                            contentPadding:
                                new EdgeInsets.symmetric(vertical: 22.0),
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
                            onPressed: () {
                              var cartBlockContex =
                                  BlocProvider.of<AuthenticationBloc>(context);
                              _onBackPressed(cartBlockContex);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }

  Future<bool> _onBackPressed(AuthenticationBloc cartBlockContex) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  cartBlockContex.add(LoggedOut());
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}
