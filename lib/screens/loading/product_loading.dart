import 'package:flutter/material.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductLoadingPage extends StatefulWidget {
  ProductLoadingPage({Key key}) : super(key: key);

  @override
  _ProductLoadingPageState createState() => _ProductLoadingPageState();
}

class _ProductLoadingPageState extends State<ProductLoadingPage> {
  User user = new User(1, "Demo", null, "_slug", "_country", "_country_flag",
      "000", "_userEmail", "123", "12");
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
    List<String> imageList = new List();
    imageList.add('assets/backgrounds/levelone.png');
    int level;
    int point = int.parse(user.points);
    // if(point<){}
    for (var i = 0; i < 9; i++) {
      if (i * 500 < point && point < (i + 1) * 500) {
        level = i + 1;
      }
      if (point < 500) {
        level = 1;
      }
    }
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
                        ' ',
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
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Center(
                child: SizedBox(
                    //child: CircularProgressIndicator(),
                    ),
              ),
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
