import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import 'package:purchasing_lanka_international/screens/request_access/photo.dart';
import 'package:purchasing_lanka_international/screens/request_access/request_access_page.dart';

class RequestAccessHome extends StatefulWidget {
  @override
  _RequestAccessHomeState createState() => _RequestAccessHomeState();
}

class _RequestAccessHomeState extends State<RequestAccessHome> {
  @override
  Widget build(BuildContext context) {
    // get user details and Token from Authenticat Bloc
    return Scaffold(
      body: BlocProvider(
        builder: (context) {
          return RequestAccessBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          );
        },
        child: RequestAccess(),
      ),
    );
  }
}
