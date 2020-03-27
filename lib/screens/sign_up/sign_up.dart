import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_event.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_event.dart';
import 'package:purchasing_lanka_international/bloc/request_access_state.dart';
import 'package:purchasing_lanka_international/screens/loading_screens/loading_screen.dart';
import 'package:purchasing_lanka_international/screens/loading_screens/rules.dart';

class SignUpPage extends StatefulWidget {
  String token;
  SignUpPage(this.token);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
//final _lastnameController = TextEditingController();
  String _country = "United States";
  String _countryFlag = "assets/flags/us_flag.png";
//to update recept
  CameraController _controller;
  List<CameraDescription> camera;
  Future<void> _initializeControllerFuture;
  int i = 0;
  Country _selected;
  String imagePath = 'assets/backgrounds/download.jpg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    _onRequestButtonPressed() {
      BlocProvider.of<RequestAccessBloc>(context).add(
        PressLoadingScreen(
          firstname: _firstnameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          country: _country,
          countryFlag: _countryFlag,
          token: widget.token,
        ),
      );
    }

    _goBackToLogin() {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
          if (state is RequestingState) {
            // LoginPage();
            CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber));
          }
          if (state is PressLoadingScreenState) {
            return LoadingScreen(state.username, state.firstname, state.email,
                state.password, state.country, state.countryFlag, state.token);
          }
          if (state is PressRulescreenState) {
            return Rules(state.username, state.firstname, state.email,
                state.password, state.country, state.countryFlag, state.token);
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
                  "WELCOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontSize: 16.0),
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
                                      text: "Pleace fill in your information",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Apple',
                                          fontSize: 12.0)),
                                ],
                              ),
                            ),
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
                            SizedBox(height: 15.0),
                            Container(
                              alignment: Alignment(-1.0, 0.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.white),
                                ),
                              ),
                              child: CountryPicker(
                                showDialingCode: false,
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
                            SizedBox(height: 25.0),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a Snackbar.
                                    CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.amber));
                                    if (state is! RequestingState) {
                                      _onRequestButtonPressed();
                                    }
                                  } else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Invalid conten'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        width: 2, color: Colors.amberAccent),
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
