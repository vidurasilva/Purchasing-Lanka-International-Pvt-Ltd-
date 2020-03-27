import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_bloc.dart';
import 'package:purchasing_lanka_international/bloc/cart_event.dart';
import 'package:purchasing_lanka_international/bloc/cart_state.dart';
import 'package:purchasing_lanka_international/models/cart_item_details.dart';
import 'package:purchasing_lanka_international/screens/loading/cart_loading.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:intl/intl.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';

import 'package:uni_links/uni_links.dart';

enum UniLinksType { string, uri }

class CartPage extends StatefulWidget {
  CartPage() : super();
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = null; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _tipController = TextEditingController();
  var token = getTokenFromPref();
  var users = getUserFromPref();
  int updatetotalPrice;
  UniLinksType _type = UniLinksType.string;
  String _latestLink = 'Unknown';
  Uri _latestUri;
  bool checkOut = false;
  List<ItemDetails> checkoutItemDetails;
  String checkOutPoint;
  int checkoutTip;
  StreamSubscription _sub;

  void setError(dynamic error) {
    // _scaffoldKey.currentState
    //     .showSnackBar(SnackBar(content: Text(error.toString())));
    // setState(() {
    //   _error = error.toString();
    // });
    print(error.toString());
  }

  @override
  void initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_pkmUaZRI6WwpyTTBFAXkTzgP009ywg8JNs",
        merchantId: "10itsolutions",
        androidPayMode: 'test'));
    initPlatformState();
  }

  initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
    print('init platform state');
  }

  /// An implementation using a [String] link
  initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });

    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print(' got link success: $link');

      BlocProvider.of<CartBloc>(context).add(
          ChechOutButtonPress(checkoutItemDetails, checkOutPoint, checkoutTip));
      checkoutItemDetails = null;
      checkOutPoint = null;
      checkoutTip = null;
      lartChechOutLoading(context);
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }

  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }

  @override
  void onTabTappedTotalPrice(int index, int totaltip) {
    setState(() {
      updatetotalPrice = index + totaltip;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return CartLoadingPage();
            }
            if (state is CartEmptyState) {
              return Scaffold(
                // resizeToAvoidBottomPadding: false,
                // resizeToAvoidBottomInset: false,
                body: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Center(
                        child: Text(
                          'You do not have any items in your cart.\nLet'
                          's get shopping!',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            fontFamily: 'Lato',
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CartLoadedState) {
              var itemList = state.items;
              // String point =
              // itemList[0].variation['attribute_pa_point'].toString();
              int totalPoints = 0;
              User user = state.user;
              int flutterBalance = int.parse(state.totalPrice);
              final oCcy = new NumberFormat("#,##0.00", "en_US");
              String formattotalPrice = oCcy.format(flutterBalance);

              final List<int> colorCodes = <int>[4294967295, 100];
              for (var i = 0; i < itemList.length; i++) {
                int tempoint = int.parse(
                    itemList[i].variation['attribute_pa_point'].toString());

                totalPoints = totalPoints + tempoint;
              }
              return new WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    // resizeToAvoidBottomInset: false,
                    body: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(10),
                                itemCount: itemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int i = index % 2;

                                  /// var price = itemList[index].price;int i = index % 2;
                                  var unFormatPrice = (itemList[index].price) /
                                      itemList[index].quantity;
                                  //curruncy converter
                                  final oCcy =
                                      new NumberFormat("#,##0.00", "en_US");
                                  String price = oCcy.format(unFormatPrice);
                                  String totalCartPrice =
                                      oCcy.format(itemList[index].price);

                                  return Center(
                                    child: Container(
                                      height: 145,
                                      color: Colors.grey[colorCodes[i]],
                                      child: Center(
                                          child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        // shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            child: Divider(
                                              color: Colors.black,
                                              height: 1,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Image.network(
                                                    itemList[index].image_path,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 7,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        // leading: Icon(Icons.title),
                                                        title: Text(
                                                          itemList[index].name,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Lato',
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              height: 3),
                                                        ),
                                                        subtitle: Text(
                                                          ' ${itemList[index].quantity} x \$ $price',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Lato',
                                                              fontSize: 14.0,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                        dense: true,
                                                      ),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Container(
                                                      height: 45,
                                                      child: ListTile(
                                                        // leading: Icon(Icons.title),
                                                        title: Text(
                                                          totalCartPrice,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Lato',
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        subtitle: Text(
                                                          "${itemList[index].variation['attribute_pa_point'].toString()} point",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Lato',
                                                              fontSize: 14.0,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                        dense: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    // alignment: Alignment.topCenter,
                                                    padding:
                                                        EdgeInsets.only(top: 1),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(CartItemDeleteButtonPressed(
                                                                itemList[index]
                                                                    .key));
                                                        print(itemList[index]
                                                            .key);

                                                        return showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                                  () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              });
                                                              return Center(
                                                                child:
                                                                    new SizedBox(
                                                                  height: 50.0,
                                                                  width: 50.0,
                                                                  child: new CircularProgressIndicator(
                                                                      value:
                                                                          null,
                                                                      valueColor: new AlwaysStoppedAnimation<
                                                                              Color>(
                                                                          Colors
                                                                              .amber)),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      )),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 12, 25, 12),
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
                                          child: Text(
                                              '\$ $formattotalPrice', //set total price
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: 'Lato',
                                                  fontSize: 12)),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '$totalPoints points', //set sub-total points
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 15, 25, 12),
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
                                          // child: SingleChildScrollView(
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please input tip';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Enter your Tip'),
                                            keyboardType: TextInputType.number,
                                            controller: _tipController,
                                            onChanged: (text) {
                                              int totalitemprice =
                                                  int.parse(formattotalPrice);
                                              int totaltip = int.parse(
                                                  _tipController.text);
                                              onTabTappedTotalPrice(
                                                  totalitemprice, totaltip);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '$totalPoints x3 points', //set points for the tip
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 12, 25, 12),
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
                                          child: (updatetotalPrice != null)
                                              ? Text(
                                                  '\$ ${updatetotalPrice}', //set TOTAL price
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Lato',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600))
                                              : Text(
                                                  '\$ $formattotalPrice', //set TOTAL price
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Lato',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${totalPoints * 3} points', //set TOITAL points
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: 'Lato',
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      ButtonTheme(
                                        height: 40,
                                        minWidth: 340,
                                        child: RaisedButton(
                                            child: const Text('Checkout',
                                                style: TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            color: Colors.black,
                                            textColor: Colors.white,
                                            elevation: 5,
                                            onPressed: () {
                                              String tipString = "0";
                                              if (_tipController.text != '') {
                                                tipString = _tipController.text;
                                              }
                                              int tip = int.parse(tipString);
                                              _onCheckout(itemList, user,
                                                  state.totalPrice);
                                              checkoutItemDetails = itemList;
                                              checkOutPoint = state.totalPrice;
                                              checkoutTip = tip;
                                            }),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                        'Tip money gives x3 the points of normal purchases.',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Lato',
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ));
            }
          },
        ),
      ),
    );
  }

  Future<void> _onCheckout(
      List<ItemDetails> itemList, User user, String totalPrice) async {
    print('Çheckout to Stripe!');

    //_saveCard();
    _payWithCard();
    //_doNativePayment(itemList, user, totalPrice);

    return;
  }

  Future<void> _saveCard() async {
    await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) async {
      print(Text('Received ${paymentMethod.id}'));
    }).catchError(setError);
  }

  void _payWithCard() {
    StripePayment.createSourceWithParams(SourceParams(
      type: 'ideal',
      amount: 333,
      currency: 'eur',
      returnURL: 'richkids://payment_redirect',
    )).then((source) {
      setState(() {
        _source = source;
      });
    }).catchError(setError);
  }

  void _doNativePayment(
      List<ItemDetails> itemList, User user, String totalPrice) {
    if (Platform.isIOS) {
      //_controller.jumpTo(450);
      print('iOS jump');
    }
    StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        total_price: "$totalPrice",
        currency_code: "USD",
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'DE',
        currencyCode: 'EUR',
        items: [
          ApplePayItem(
            label: 'Test',
            amount: '13',
          )
        ],
      ),
    ).then((token) {
      setState(() {
        print(Text('Received ${token.tokenId}'));
        _paymentToken = token;
        //Token not null delete item on cart
        String tipString = "0";
        if (_tipController.text != '') {
          tipString = _tipController.text;
        }
        int tip = int.parse(tipString);
        BlocProvider.of<CartBloc>(context)
            .add(ChechOutButtonPress(itemList, user.points, tip));
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
                      semanticsLabel: "payment completed",
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.amber)),
                ),
              );
            });
      });
    }).catchError(setError);
  }

  Future<bool> _onBackPressed() {
    print('Back button pressed');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}

Widget lartChechOutLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 4), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text('Payment is Successfull'),
              ],
            ),
          ),
        );
      });
}
