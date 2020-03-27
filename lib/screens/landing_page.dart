import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_event.dart';
import 'package:purchasing_lanka_international/bloc/product_event.dart';
import 'package:purchasing_lanka_international/bloc/nav_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_state.dart';
import 'package:purchasing_lanka_international/bloc/profile_bloc.dart';
import 'package:purchasing_lanka_international/bloc/profile_event.dart';
import 'package:purchasing_lanka_international/bloc/score_bloc.dart';
import 'package:purchasing_lanka_international/bloc/score_event.dart';
import 'package:purchasing_lanka_international/screens/add_catogory/catogory.dart';
import 'package:purchasing_lanka_international/screens/cart/cart_page.dart';
import 'package:purchasing_lanka_international/screens/product/product_page.dart';
import 'package:purchasing_lanka_international/screens/score/score_page.dart';
import 'package:purchasing_lanka_international/screens/user_profile/user_profile_page.dart';
import 'package:purchasing_lanka_international/widgets/bottom_nav_bar.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavBloc bottomNavigationBloc = BlocProvider.of<NavBloc>(context);

    return Scaffold(
      body: BlocBuilder<NavBloc, NavState>(
        bloc: bottomNavigationBloc,
        builder: (BuildContext context, NavState state) {
          if (state is HomeState) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: BlocProvider(
                builder: (context) => HomeBloc()..add(ProductLoading()),
                child: ProductPage(state.categori),
              ),
            );
          }
          if (state is CatogoryState) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: BlocProvider(
                builder: (context) => HomeBloc()..add(ProductLoading()),
                child: CatogoryPage(),
              ),
            );
          }

          if (state is CartState) {
            return Scaffold(
              body: BlocProvider(
                builder: (context) => CartBloc()..add(CartLoading()),
                child: CartPage(),
              ),
            );
          }
          if (state is ScoreBoardState) {
            return Scaffold(
              body: BlocProvider(
                builder: (context) => ScoreBloc()..add(ScoreLoading()),
                child: ScoreBoardPage(),
              ),
            );
          }
          if (state is UserProfileState) {
            return Scaffold(
                body: BlocProvider(
              builder: (context) => ProfileBloc()..add(ProfileLoading()),
              child: UserProfilePage(),
            ));
          }
          return Container();
        },
      ),
      bottomNavigationBar: AppNavBar(),
    );
  }
}
