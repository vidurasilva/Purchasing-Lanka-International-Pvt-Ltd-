import 'package:flutter/material.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/screens/score/score_page.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScoreLoadingPage extends StatefulWidget {
  @override
  _ScoreLoadingPageState createState() => _ScoreLoadingPageState();
}

class _ScoreLoadingPageState extends State<ScoreLoadingPage> {
  User user = new User(1, "Demo", null, "_slug", "_country", "_country_flag",
      "000", "_userEmail", "124", "12");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserFromPref().then((result) {
      print("result: ${result.toString()}");
      user = result;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int level = getLevel(user.points);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  user.name, //Remove USER NAME and fill the Name
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700),
                ),
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
                  'Lv.$level /${user.points}', //Level and poins for now
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 10.0,
                  ),
                ),
              )
            ],
          )
        ],
      ),

      //------ Owners details goes from here ------//

      body: Column(children: <Widget>[
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Text(
                        '$level', //Set owners Level
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Level',
                      style: TextStyle(
                          color: Colors.grey[350],
                          fontFamily: 'Lato',
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      user.points, //Set owners total points
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Points',
                      style: TextStyle(
                          color: Colors.grey[350],
                          fontFamily: 'Lato',
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Text(
                        '0', //set owners Number of Purchases
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Purchases',
                      style: TextStyle(
                          color: Colors.grey[350],
                          fontFamily: 'Lato',
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Overall',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        height: 20,
                        child: DropdownButton<String>(
                          items: <String>['Overall', 'Country'] // Dropdown menu
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          icon: Icon(MdiIcons.chevronDown),
                          iconSize: 20,
                          underline: SizedBox(), //to remove the underline
                          elevation: 16,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    'Points',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[350],
                        fontFamily: 'Lato',
                        fontSize: 13,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      child: Text(
                    'Level',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[350],
                        fontFamily: 'Lato',
                        fontSize: 13,
                        fontStyle: FontStyle.italic),
                  ))),
              Expanded(
                flex: 2,
                child: Container(
                    child: Text(
                  'Country',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[350],
                      fontFamily: 'Lato',
                      fontSize: 13,
                      fontStyle: FontStyle.italic),
                )),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Divider(
            color: Colors.white,
            height: 2,
          ),
        ),
        Container(
          height: 450,
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Center(
              child: SizedBox(
                  // child: CircularProgressIndicator(),
                  ),
            ),
          ),
        ),
      ]),
    );
  }
}
