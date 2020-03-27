import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';

class AccessPrivilege extends StatefulWidget {
  @override
  _AccessPrivilegeState createState() => _AccessPrivilegeState();
}

class _AccessPrivilegeState extends State<AccessPrivilege> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: RaisedButton(
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        },
        color: Colors.black,
        child: Text(
          "Please waiting for Verification \n \n Back To Loging",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      )),
    );
  }
}
