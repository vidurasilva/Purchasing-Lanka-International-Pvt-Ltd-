import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_event.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppNavBar extends StatefulWidget {
  AppNavBar({Key key}) : super(key: key);

  @override
  _AppNavBarState createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _selectedIndex = 1;
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
              padding: EdgeInsets.all(2),
              onPressed: () {
                BlocProvider.of<NavBloc>(context)
                    .add(GoToCatogoryButtonPressedNav());
                onTabTapped(1);
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop(true);
                      });
                      return Center(
                        child: new SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: new CircularProgressIndicator(
                              value: null,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.amber)),
                        ),
                      );
                    });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    (_selectedIndex == 1)
                        ? MdiIcons.home
                        : MdiIcons.homeOutline,
                    color:
                        (_selectedIndex == 1) ? Colors.black : Colors.black54,
                    size: 20.0,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color:
                          (_selectedIndex == 1) ? Colors.black : Colors.black54,
                      fontWeight: (_selectedIndex == 1)
                          ? FontWeight.w900
                          : FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),
                ],
              )),
          FlatButton(
            padding: EdgeInsets.all(2),
            onPressed: () {
              BlocProvider.of<NavBloc>(context)
                  .add(GoToScoreBoadrButtonPressedNav());
              onTabTapped(2);
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pop(true);
                    });
                    return Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                            value: null,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.amber)),
                      ),
                    );
                  });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  (_selectedIndex == 2)
                      ? MdiIcons.trophy
                      : MdiIcons.trophyOutline,
                  color: (_selectedIndex == 2) ? Colors.black : Colors.black54,
                  size: 20.0,
                ),
                Text(
                  'Score',
                  style: TextStyle(
                    // color: Colors.black,
                    color:
                        (_selectedIndex == 2) ? Colors.black : Colors.black54,
                    fontWeight: (_selectedIndex == 2)
                        ? FontWeight.w900
                        : FontWeight.normal,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
              padding: EdgeInsets.all(2),
              onPressed: () {
                BlocProvider.of<NavBloc>(context)
                    .add(GoToCartButtonPressedNav());
                onTabTapped(3);
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop(true);
                      });
                      return Center(
                        child: new SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: new CircularProgressIndicator(
                              value: null,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.amber)),
                        ),
                      );
                    });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    (_selectedIndex == 3)
                        ? MdiIcons.cart
                        : MdiIcons.cartOutline,
                    color:
                        (_selectedIndex == 3) ? Colors.black : Colors.black54,
                    size: 20.0,
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(
                      color:
                          (_selectedIndex == 3) ? Colors.black : Colors.black54,
                      fontWeight: (_selectedIndex == 3)
                          ? FontWeight.w900
                          : FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),
                ],
              )),
          FlatButton(
            padding: EdgeInsets.all(2),
            onPressed: () {
              BlocProvider.of<NavBloc>(context)
                  .add(GoToUserProfileButtonPressedNav());
              onTabTapped(4);
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(true);
                    });
                    return Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                            value: null,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.amber)),
                      ),
                    );
                  });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  (_selectedIndex == 4)
                      ? MdiIcons.account
                      : MdiIcons.accountOutline,
                  color: (_selectedIndex == 4) ? Colors.black : Colors.black54,
                  size: 20.0,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    color:
                        (_selectedIndex == 4) ? Colors.black : Colors.black54,
                    fontWeight: (_selectedIndex == 4)
                        ? FontWeight.w900
                        : FontWeight.normal,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
