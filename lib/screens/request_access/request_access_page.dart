import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_event.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_event.dart';
import 'package:purchasing_lanka_international/bloc/request_access_state.dart';
import 'package:purchasing_lanka_international/screens/request_access/takePictureScreen.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

class RequestAccess extends StatefulWidget {
  @override
  _RequestAccessState createState() => _RequestAccessState();
}

class _RequestAccessState extends State<RequestAccess> {
  final _firstnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
//final _lastnameController = TextEditingController();
  String _country;
  String _countryFlag;
//to update recept
  CameraController _controller;
  List<CameraDescription> camera;
  Future<void> _initializeControllerFuture;
  int i = 0;
//Set imagePath;
  bool hasPicture = false;
  bool imageButtonPress = false;
//country picker
  Country _selected;

  String imagePath = 'assets/backgrounds/download.jpg';

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  Future<void> _initCamera() async {
    camera = await availableCameras();
    _controller = CameraController(camera[0], ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    _onRequestButtonPressed() {
      BlocProvider.of<RequestAccessBloc>(context).add(
        PressRequestingAccess(
          firstname: _firstnameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          country: _country,
          countryFlag: _countryFlag,
        ),
      );
    }

    _goBackToLogin() {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }

    return new WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<RequestAccessBloc, RequestAccessState>(
        listener: (context, state) {
          if (state is RequestAccessFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<RequestAccessBloc, RequestAccessState>(
            builder: (context, state) {
          if (state is RequestedState) {
            // LoginPage();
          }
          return Container(
            child: Scaffold(
              backgroundColor: Colors.black,
              //resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => {_goBackToLogin()},
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "Request Membership",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontSize: 18.0),
                ),
                centerTitle: true,
              ),
              body: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/backgrounds/loginbackground.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "This is an exclusive, invite-only game. If you do not have an invitation you can apply below. To be eligle to compete it is recommended that you have a minimum net worth of \$ 1 000 000.\n\n You may choose how you can prove your net worth. At least one valid ID is required. Some members have receipts of large purchases and other images proving their wealth. These may be added below. For confidentiality reasons, no personal details will be shared, unless you wish to do so.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Apple',
                                          fontSize: 14.0)),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                ),
                                child: (hasPicture) == true
                                    ? new Container(
                                        height: 110,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.file(
                                          File(imagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : new Container(
                                        height: 110,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Colors.white12,
                                                child: FlatButton(
                                                  child: Icon(Icons.camera_alt,
                                                      color: Colors.white30,
                                                      size: 30.0),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TakePictureScreen()),
                                                    ).then((value) {
                                                      updateImage();
                                                    });
                                                    imageButtonPress = true;
                                                  },
                                                )),
                                            SizedBox(height: 10),
                                            Text(
                                              'Tap here to upload photo proof',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white30,
                                                  fontFamily: 'Georgia',
                                                  fontSize: 10.0),
                                            ),
                                          ],
                                        ))),
                            SizedBox(height: 15.0),
                            TextFormField(
                              validator: validateName,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'FULL NAME',
                                labelStyle: TextStyle(
                                    fontFamily: 'Georgia', color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              controller: _firstnameController,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'USERNAME',
                                labelStyle: TextStyle(
                                    fontFamily: 'Georgia', color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              controller: _usernameController,
                              validator: validateName,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'PERSONAL EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Georgia', color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: validateEmail,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'Georgia', color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              controller: _passwordController,
                              validator: validatePassword,
                              obscureText: true,
                            ),
                            SizedBox(height: 15.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CountryPicker(
                                showDialingCode: true,
                                nameTextStyle: TextStyle(
                                    fontFamily: 'Georgia', fontSize: 18),
                                onChanged: (Country country) {
                                  setState(() {
                                    _selected = country;
                                    print(country.name);
                                    _country = country.name;
                                    _countryFlag = country.asset;
                                  });
                                },
                                selectedCountry: _selected,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      canvasColor: Colors.transparent),
                                  child: (imageButtonPress) == true
                                      ? FlatButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          textColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            side:
                                                BorderSide(color: Colors.white),
                                          ),
                                          child: Text(
                                            'Request Membership',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            // Validate returns true if the form is valid, or false
                                            // otherwise.
                                            if (_formKey.currentState
                                                .validate()) {
                                              // If the form is valid, display a Snackbar.
                                              CircularProgressIndicator(
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                          Color>(Colors.amber));
                                              if (state is! RequestingState) {
                                                _onRequestButtonPressed();
                                              }
                                            } else {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('Invalid conten'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      : new FlatButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          textColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            side:
                                                BorderSide(color: Colors.white),
                                          ),
                                          child: Text(
                                            'Request Membership',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            // Validate returns true if the form is valid, or false
                                            // otherwise.
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Pleace Uploade Receipt Image'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                        )),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              child: state is RequestingState
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.amber))
                                  : null,
                            ),
                            SizedBox(height: 15.0),
                          ],
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  updateImage() async {
    String path = await getReceiptImageFromPref();
    setState(() {
      hasPicture = true;
      imagePath = path;
    });
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) return 'Enter Valid Email';
  if (value.isEmpty)
    return 'Please enter Email Addres';
  else
    return null;
}

String validateName(String value) {
  if (value.isEmpty) return 'Please enter Name';
  if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String validateCountry(String value) {
  if (value.isEmpty) return 'Please enter country';
  if (value.length < 3)
    return 'Country name is invalid';
  else
    return null;
}

String validatePassword(String value) {
  if (value.isEmpty) return 'Please enter Password';
  if (value.length < 3)
    return 'Password  is invalid';
  else
    return null;
}
