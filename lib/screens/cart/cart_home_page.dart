import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_event.dart';
import 'package:purchasing_lanka_international/screens/cart/cart_page.dart';

class CartHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get user details and Token from Authenticat Bloc
    return Scaffold(
      body: BlocProvider(
        builder: (context) => CartBloc()..add(CartLoading()),
        child: CartPage(),
      ),
    );
  }
}
