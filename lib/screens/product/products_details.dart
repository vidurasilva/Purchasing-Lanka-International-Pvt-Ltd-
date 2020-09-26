import 'package:flutter/material.dart';
import 'package:purchasing_lanka_international/bloc/product_event.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductDetails extends StatefulWidget {
  final productDetailsId;
  final productDetailsName;
  final productDetailsPrice;
  final productDetailsCategoreName;
  final productDetailsPicture;
  final productDetailsCartItemQuentity;
  final productDetailsAttributes;
  final productDetailsDefaultAttr;
  final productDetailsDescription;
  final contextHome;

  ProductDetails(
      {this.productDetailsId,
      this.productDetailsName,
      this.productDetailsPicture,
      this.productDetailsPrice,
      this.productDetailsCategoreName,
      this.productDetailsCartItemQuentity,
      this.productDetailsAttributes,
      this.productDetailsDefaultAttr,
      this.productDetailsDescription,
      this.contextHome});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  int imageValue = 0;
  int _selectedIndex = 0;
  // int _selectedChoiceIndex = 0;
  List sellectedAttributes = new List();
  int carti;
  String dfaultPointForItem = '0';
  List<bool> selectedColor = [true, false, false, false];
  List attributesName = new List();
  List attributesOption = new List();
  List detailesAttributes = new List();
  var defaultAttribute;

  void onTabTapped(int index, int quantitys) {
    setState(() {
      _selectedIndex = index;
      carti = quantitys + widget.productDetailsCartItemQuentity;
    });
  }

  void onTabTappedChoice(int index, String choiceOpton) {
    setState(() {
      sellectedAttributes[index] = choiceOpton;
    });
  }

  @override
  void initState() {
    super.initState();
    carti = widget.productDetailsCartItemQuentity;
    defaultAttribute = widget.productDetailsDefaultAttr[0]["option"];
    print(defaultAttribute[0]);
    detailesAttributes = widget.productDetailsAttributes;
    if (detailesAttributes.length > 0) {
      for (var i = 0; i < detailesAttributes.length; i++) {
        var vvv = detailesAttributes[i];
        sellectedAttributes.add(0);
        var attrName = vvv["name"];
        var attriOption = vvv["options"];
        if (attrName != 'point') {
          attributesName.add(attrName);
          attributesOption.add(attriOption);
        } else {
          dfaultPointForItem = attriOption[0];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Expanded(
            //   flex: 3,
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                widget.contextHome.add(ProductLoading());
              }, //add back button function
            ),
            // ),
            Expanded(
              // flex: 17,
              child: Center(
                child: Text(
                  widget.productDetailsName,
                  style: TextStyle(fontSize: 20),
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
                padding: EdgeInsets.all(5),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    IconButton(
                      // icon: Icon(Icons.card_travel),
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
                          child: Text('$carti',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: buildCard(),
            height: 240,
          ),
          Container(
            // padding: EdgeInsets.symmetric(vertical: 10),
            child: buildGalary(),
            height: 110,
          ),

          // ResponsiveContainer
          Container(
            // heightPercent: 50,
            // widthPercent: 50,
            child: buildDescription(),
            // height: 250,
          ),
          Container(
            child: buildChoice(),
            height: 235,
          ),
          Container(
            child: buildAddToRow(context),
            height: 60,
          ),
        ],
      ),
    );
  }

  Widget buildCard() {
    return Card(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                widget.productDetailsPicture[imageValue].src,
                fit: BoxFit.fitWidth,
                // width: MediaQuery.of(context).size.width * 1,
              ),
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGalary() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(
              () {
                imageValue = 1;
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1)),
              child: Image.network(
                widget.productDetailsPicture[1].src,
                fit: BoxFit.fill,
                // width: MediaQuery.of(context).size.width - 20,
              ),
              // padding: EdgeInsets.all(20),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(
              () {
                imageValue = 2;
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 90,
              width: 90,
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1)),
              child: Image.network(
                widget.productDetailsPicture[2].src,
                fit: BoxFit.fill,

                // width: MediaQuery.of(context).size.width - 20,
              ),
              // padding: EdgeInsets.all(20),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(
              () {
                imageValue = 3;
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1)),
              child: Image.network(
                widget.productDetailsPicture[3].src,
                fit: BoxFit.fill,
                // width: MediaQuery.of(context).size.width - 20,
              ),
              // padding: EdgeInsets.all(20),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChoice() {
    // TODO: change color to a drop down menu
    return Column(
      children: <Widget>[
        // Expanded(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 131.0),
          child: Divider(
            color: Colors.white,
            height: 30,
            // thickness: 1,
          ),
        ),

        (attributesName.length != 0)
            ? builderChoicesLevel(attributesName)
            : Container(
                child: Text("This Is Better One"),
              ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 130.0),
          child: Divider(
            color: Colors.white,
            height: 30,
            // thickness: 1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qty    ',
              style: TextStyle(fontFamily: 'Lato', fontSize: 16.0),
            ),
            IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    quantity = --quantity == 0 ? 1 : quantity;
                  });
                }),
            Text(
              quantity.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                }),
          ],
        ),
        // ),
      ],
    );
  }

  Widget builderChoicesLevel(productDetailsAttributes) {
    return new Container(
      height: 125,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 1),
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                for (var i = 0; i < productDetailsAttributes.length; i++)
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.5),
                        child: Text(
                          attributesName[i],
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 17.0,
                              color: Colors.white),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var j = 0; j < attributesOption[i].length; j++)
                              FlatButton(
                                child: Text(
                                  '${attributesOption[i][j]}',
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 14.0,
                                      color: (sellectedAttributes[i] ==
                                              attributesOption[i][j])
                                          ? Colors.red
                                          : Colors.white),
                                ),
                                onPressed: () {
                                  onTabTappedChoice(i, attributesOption[i][j]);
                                  widget.productDetailsAttributes[i + 1]
                                      ['options'] = [attributesOption[i][j]];
                                },
                              ),
                          ])
                    ],
                  ),
              ],
            );
          }),
    );
  }

  Widget buildSize(String sizeName, int i) {
    int press;
    setState(() {
      press = 1;
    });
    return InkWell(
      onTap: () {
        setState(() {
          for (int j = 0; j < selectedColor.length; j++) {
            selectedColor[j] = false;
            if (j == i) selectedColor[j] = true;
          }
        });
      },
      child: Container(
        // margin: EdgeInsets.only(left: 8),
        child: Center(
          child: selectedColor[i]
              ? FlatButton(
                  child: Text(sizeName),
                  color: (press == 1) ? Colors.red : Colors.red[300],
                  // highlightColor: Colors.green,
                  // ),
                  onPressed: () {
                    print('press1');
                    press = 1;
                    print(press);
                  },
                )
              : FlatButton(
                  child: Text(
                    sizeName,
                  ),
                  color: (press == 2) ? Colors.red : Colors.yellow[350],
                  onPressed: () {
                    print('press2');
                    press = 2;
                    print(press);
                  },
                ),
        ),
      ),
    );
  }

  Widget buildColor(Color color, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          for (int j = 0; j < selectedColor.length; j++) {
            selectedColor[j] = false;
            if (j == i) selectedColor[j] = true;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        child: selectedColor[i]
            ? Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              )
            : null,
        decoration: ShapeDecoration(
            color: color,
            shape:
                CircleBorder(side: BorderSide(color: Colors.white, width: 1))),
        height: 20,
        width: 20,
      ),
    );
  }

  Widget buildAddToRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: ButtonTheme(
              height: 40,
              minWidth: 340,
              child: RaisedButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  elevation: 5,
                  onPressed: (_selectedIndex == 0)
                      ? () async {
                          String token = await getTokenFromPref();
                          await addItem(widget.productDetailsId, quantity,
                              widget.productDetailsAttributes, token);
                          onTabTapped(1, quantity);
                          widget.contextHome.add(ProductLoading());
                        }
                      : null,
                  child: (_selectedIndex == 0)
                      ? Text('Add to Cart',
                          style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: (_selectedIndex == 0)
                                  ? Colors.black
                                  : Colors.white))
                      : Text('Already in Cart',
                          style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: (_selectedIndex == 0)
                                  ? Colors.black
                                  : Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${widget.productDetailsName}',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Lato', fontSize: 22.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 130.0),
          child: Divider(
            color: Colors.white,
            height: 30,
            // thickness: 1,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "${widget.productDetailsPrice} USD",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Lato', fontSize: 18.0)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "$dfaultPointForItem points",
                style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Lato',
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: widget.productDetailsDescription.substring(
                    3, (widget.productDetailsDescription.length) - 5),
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Lato', fontSize: 14.0)),
          ),
        ),
      ],
    );
  }
}
