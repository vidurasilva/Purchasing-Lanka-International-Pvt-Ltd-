import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/login_bloc.dart';
import 'package:purchasing_lanka_international/bloc/login_event.dart';
import 'package:purchasing_lanka_international/bloc/login_state.dart';

class AuthCodePage extends StatefulWidget {
  @override
  _AuthCodePageState createState() => _AuthCodePageState();
}

class _AuthCodePageState extends State<AuthCodePage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final _usernameController = TextEditingController();
  final _userHardCode = 'vidura';
  final _passwordController = '123456';
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        EnterCodeButtonPressed(
          // username: _usernameController.text,
          username: _userHardCode,
          password: _passwordController,
        ),
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/loginbackground.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  labelText: 'Enter your Code',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Apple',
                                    color: Colors.white,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                controller: _usernameController,
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Center(
                              child: GestureDetector(
                                onTap: state is! LoginLoading
                                    ? _onLoginButtonPressed
                                    : null,
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
                            SizedBox(height: 22),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: state is LoginLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.amber))
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
