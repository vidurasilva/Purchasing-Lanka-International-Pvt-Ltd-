import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/authentication_event.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final themeColor = new Color(0xfff5a623);

class LoadingIndicator extends StatelessWidget {
  User user = new User(1, " ", null, "_slug", "_country", "_country_flag",
      "000", "_userEmail", "123", "12");

  @override
  Widget build(BuildContext context) {
    List<String> imageList = new List();
    imageList.add('assets/backgrounds/levelone.png');
    int level = 0;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.cartOutline),
                  onPressed: () {},
                ),
                Positioned(
                  top: 5.0,
                  right: 5.0,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: new Text(
                        '0',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Center(
                child: Text(user.name), //Remove USER NAME and fill the Name
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Text(
                    'Lv.$level/${user.points}'), //Remove Text data and fill the amount
              )
            ],
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          levelHeaderView(1, 1, imageList),
          Container(
            child: Center(
              child: SizedBox(
                  child: AlertDialog(
                title: Text('Internal Server Error?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('LogOut'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget levelHeaderView(int levelOfList, int ownUserLevel, List image) {
  //Level Header
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    height: 130,
    decoration: BoxDecoration(
        image: DecorationImage(
      image: (levelOfList <= ownUserLevel)
          ? AssetImage(image[levelOfList - 1])
          : AssetImage('assets/backgrounds/levelthree.png'),
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
    )),
    child: Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'Level $levelOfList \n',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Lato', fontSize: 30.0)),
            (levelOfList <= ownUserLevel)
                ? TextSpan(
                    text:
                        '\$${(levelOfList - 1) * 500} - \$${500 * levelOfList}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 10.0))
                : TextSpan(
                    text: 'BLOCKED',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 35.0)),
          ],
        ),
      ),
    ),
  );
}
