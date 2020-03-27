import 'package:flutter/material.dart';

class CartLoadingPage extends StatefulWidget {
  @override
  _CartLoadingPageState createState() => _CartLoadingPageState();
}

class _CartLoadingPageState extends State<CartLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      SizedBox(
        height: 30,
      ),
      Container(
        height: 365,
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Center(
            child: SizedBox(
                //child: CircularProgressIndicator(),
                ),
          ),
        ),
      ),
      Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Subtotal',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text('', //set total price
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Lato',
                              fontSize: 12)),
                    ),
                    Expanded(
                      child: Text('', //set sub-total points
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Lato',
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Tip',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text(' ', //set tip price
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text('', //set points for the tip
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Lato',
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('TOTAL',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text(' ', //set TOTAL price
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text('', //set TOITAL points
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Lato',
                              fontSize: 14)),
                    ),
                  ],
                ),
              ),
              ButtonTheme(
                height: 40,
                minWidth: 340,
                child: RaisedButton(
                  child: const Text('Checkout',
                      style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                  color: Colors.black,
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: () {}, //button action for checkout
                ),
              ),
              Text('Tip money gives x3 the points of normal purchases.',
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Lato',
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic)),
            ],
          ))
    ]));
  }
}
