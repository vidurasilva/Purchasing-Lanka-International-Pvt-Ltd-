import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/score_bloc.dart';
import 'package:purchasing_lanka_international/bloc/score_state.dart';
import 'package:purchasing_lanka_international/models/country_best_customers.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/screens/loading/loading.dart';
import 'package:purchasing_lanka_international/screens/loading/score_loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_country_picker/flutter_country_picker.dart';

class ScoreBoardPage extends StatefulWidget {
  @override
  _ScoreBoardPageState createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage> {
  String dropdownValue = 'Overall';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
        if (state is ScoreLoadingState) {
          // String imagepath = 'assets/backgrounds/blur_score.jpg';
          // return LoadingIndicator(imagepath);
          return ScoreLoadingPage();
        }
        if (state is ScoreLoadedState) {
          User user = state.user;
          List<BestCustomersCountryModel> bestCountry =
              state.bestContributeCountry;

          int level = getLevel(user.points);

          int positionOfList = getPosition(user, state.bestUsersList);

          //get item level list
          List<int> usersLevel = new List();
          for (var i = 0; i < state.bestUsersList.length; i++) {
            int uLevel = getLevel(state.bestUsersList[i].points);
            usersLevel.add(uLevel);
          }
          //get country name and flage list
          List<Country> displayCountry = new List();

          for (var i = 0; i < state.bestUsersList.length; i++) {
            Country tempCountry = new Country(
              asset: state.bestUsersList[i].countryFlag,
              dialingCode: "000",
              isoCode: "NE",
              name: state.bestUsersList[i].country,
              currency: "US Doller",
              currencyISO: "USD",
            );
            displayCountry.add(tempCountry);
          }
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              // titleSpacing: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        user.name,
                        style: TextStyle(fontSize: 20),
                      ), //Remove USER NAME and fill the Name
                    ),
                  )
                ],
              ),
              // automaticallyImplyLeading: false,
              // centerTitle: true,
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

            //------ Owners details goes from here ------//

            body: Column(
              children: <Widget>[
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
                              Container(
                                height: 20,
                                child: DropdownButton<String>(
                                  items: <String>[
                                    'Overall',
                                    'Country'
                                  ] // Dropdown menu
                                      .map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  value: dropdownValue,
                                  icon: Icon(MdiIcons.chevronDown),
                                  iconSize: 20,
                                  underline:
                                      SizedBox(), //to remove the underline
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
                      (dropdownValue == 'Overall')
                          ? Expanded(
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
                              )))
                          : Expanded(
                              flex: 2,
                              child: Container(
                                  child: Text(
                                'Tip',
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

                //------ Repeated list items goes from here ------//

                (dropdownValue == 'Overall')
                    ? Expanded(
                        flex: 12,
                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.bestUsersList.length,
                              scrollDirection: Axis.vertical,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 71,
                                  color: Colors.black,
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              height: 70,
                                              child: Center(
                                                  child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${index + 1}', //Set Players rank (numbers starting from 1)
                                                      style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      state.bestUsersList[index]
                                                          .name
                                                          .toString(), //Set Players name
                                                      style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    state.bestUsersList[index]
                                                        .points, //Set Players Score
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    '${usersLevel[index]}', //set players Level
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 14.0,
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                  child: Image.asset(
                                                displayCountry[index].asset,
                                                package:
                                                    "flutter_country_picker",
                                                height: 32.0,
                                                fit: BoxFit.fitWidth,
                                              )))
                                        ],
                                      ),
                                      Container(
                                        child: Divider(
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    : Expanded(
                        flex: 12,
                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.bestContributeCountry.length,
                              scrollDirection: Axis.vertical,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (BuildContext context, int index) {
                                double tipprasentage = 0;
                                var tippppp = state.bestContributeCountry[index]
                                    .countryuserdetails['total_tip'];
                                var totalpurchaseee = state
                                    .bestContributeCountry[index]
                                    .countryuserdetails['total_purchase'];

                                if (tippppp == '' || totalpurchaseee == '') {
                                  tippppp = '0';
                                  totalpurchaseee = '0';
                                }
                                int totaltip = int.parse("$tippppp");

                                int totalpurchase =
                                    int.parse("$totalpurchaseee");
                                if (totaltip != 0 && totalpurchase != 0) {
                                  tipprasentage =
                                      (totaltip / totalpurchase) * 100;
                                }

                                return Container(
                                  height: 71,
                                  color: Colors.black,
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              height: 70,
                                              child: Center(
                                                  child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${index + 1}', //Set Players rank (numbers starting from 1)
                                                      style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      "${state.bestContributeCountry[index].country}", //Set Players name
                                                      style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "${state.bestContributeCountry[index].countryuserdetails['total_points']}", //Set Players Score
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "${tipprasentage.toStringAsFixed(2)} %", //set players Level
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 14.0,
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                  child: Image.asset(
                                                state
                                                        .bestContributeCountry[
                                                            index]
                                                        .countryuserdetails[
                                                    'country_flage'],
                                                package:
                                                    "flutter_country_picker",
                                                height: 32.0,
                                                fit: BoxFit.fitWidth,
                                              )))
                                        ],
                                      ),
                                      Container(
                                        child: Divider(
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),

                //------ profile owners rank in fixed Row goes from here ------//

                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 60,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '$positionOfList', //Set Owners rank
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          user.name, //Set Owners name
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                    // )
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        user.points, //Set owners Score
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Lato',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        '$level', //set owners Level
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Container(
                                          child: Image.asset(
                                    displayCountry[positionOfList - 1].asset,
                                    package: "flutter_country_picker",
                                    height: 32.0,
                                    fit: BoxFit.fitWidth,
                                  ))))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

int getLevel(String userpoint) {
  // if(point<){}
  int point = int.parse(userpoint);
  int level;
  for (var i = 0; i < 9; i++) {
    if (i * 500 < point && point < (i + 1) * 500) {
      level = i + 1;
    }
    if (point < 500) {
      level = 1;
    }
  }
  return level;
}

int getPosition(User user, List<User> bestUsersList) {
  // if(point<){}

  int position = 1;
  for (var i = 0; i < bestUsersList.length; i++) {
    if (user.id == bestUsersList[i].id) {
      position = i;
    }
  }
  return position + 1;
}
