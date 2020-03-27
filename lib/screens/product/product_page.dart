import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_event.dart';
import 'package:purchasing_lanka_international/bloc/product_event.dart';
import 'package:purchasing_lanka_international/bloc/product_state.dart';
import 'package:purchasing_lanka_international/models/cart_add_item.dart';
import 'package:purchasing_lanka_international/models/product.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/screens/loading/product_loading.dart';
import 'package:purchasing_lanka_international/screens/product/single_product.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final String catogory;
  const ProductPage(String categori, {Key key, this.catogory})
      : super(key: key);
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductPage> {
  PageController _pageController;
  int textColorint = 10000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void setButtonAlBuy(int level) {
    setState(() {
      textColorint = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          List<String> imageList = new List();
          imageList.add('assets/backgrounds/levelone.png');
          imageList.add('assets/backgrounds/leveltwo.png');
          imageList.add('assets/backgrounds/levelthree.png');
          imageList.add('assets/backgrounds/levelone.png');
          imageList.add('assets/backgrounds/leveltwo.png');
          imageList.add('assets/backgrounds/levelthree.png');

          if (state is ProductLoadingState) {
            // String imagepath = 'assets/backgrounds/blur_product.jpg';
            // return LoadingIndicator(imagepath);
            return ProductLoadingPage();
          }
          if (state is ProductLoadingFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Please check .htaccess file'),
                backgroundColor: Colors.red,
              ),
            );
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          }
          if (state is ProductLoadedState) {
            var productLevelList = state.products;
            User user = state.user;
            int level;
            int point = int.parse(user.points);

            //
            if (point < 1999) {
              for (var i = 0; i < 9; i++) {
                if (i * 500 < point && point < (i + 1) * 500) {
                  level = i + 1;
                }
                if (point < 500) {
                  level = 1;
                }
              }
            } else {
              level = 3;
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
                                '${state.itemCount}',
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
                        child: Text(
                          user.name,
                          style: TextStyle(fontSize: 20),
                        ), //Remove USER NAME and fill the Name
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
              body: mainProductWigdet(productLevelList, level, imageList),
            );
          }
        },
      ),
    );
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
            style: DefaultTextStyle.of(context).style,
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
                      text: 'LOCKED',
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

  Widget mainProductWigdet(List<List<Product>> productsList, int ownUserLevel,
      List<String> imageList) {
    return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (BuildContext ctxt, int blockIndex) {
          List<Product> productList = productsList[blockIndex];
          bool isLevel = productList[0].isVisible;
          int totalPrice = getTotalPriceList(productList);

          bool textColour = false;
          if (textColorint == blockIndex) {
            textColour = true;
          }

          return Column(children: <Widget>[
            levelHeaderView(blockIndex + 1, ownUserLevel, imageList),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                //Currancy formating Start
                int flutterBalance = int.parse(productList[index].price);
                final oCcy = new NumberFormat("#,##0.00", "en_US");
                String formattedPrice = oCcy.format(flutterBalance);
                // Currancy formating
                return SingleProduct(
                  productId: productList[index].id,
                  productName: productList[index].name,
                  productPicture: productList[index].images,
                  productPrice: formattedPrice,
                  categoreName: productList[index].categories,
                  inCart: productList[index].inCart,
                  inLevel: productList[index].isVisible,
                  cartItemQuentity: productList[index].cartItemCount,
                  attributes: productList[index].attributes,
                  defaultAttributr: productList[index].defaultAttributes,
                  description: productList[index].description,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: ButtonTheme(
                height: 35,
                minWidth: 200,
                child: (!textColour)
                    ? RaisedButton(
                        child: isLevel
                            ? Text('Buy All',
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: (!textColour)
                                        ? Colors.black
                                        : Colors.brown))
                            : Text('Buy All',
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: (!textColour)
                                        ? Colors.black
                                        : Colors.brown)),
                        color: Colors.white,
                        textColor: Colors.black,
                        elevation: 5,
                        onPressed: () {
                          setButtonAlBuy(blockIndex);
                          if (isLevel) {
                            List<Product> proList = productsList[blockIndex];
                            for (var i = 0; i < proList.length; i++) {
                              CartAddItem itemDetails = new CartAddItem(
                                  proList[i].id, 1, proList[i].attributes);
                              BlocProvider.of<NavBloc>(context)
                                  .add(AddItemButtonPressed(itemDetails));
                              BlocProvider.of<HomeBloc>(context)
                                  .add(ProductLoading());
                            }
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Future.delayed(Duration(seconds: 4), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return Center(
                                    child: new SizedBox(
                                      height: 50.0,
                                      width: 50.0,
                                      child: new CircularProgressIndicator(
                                          value: null,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.amber)),
                                    ),
                                  );
                                });
                          }
                        },
                      )
                    : RaisedButton(
                        child: Text('Buy All',
                            style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: (!textColour)
                                    ? Colors.black
                                    : Colors.brown)),
                        onPressed: () {
                          return null;
                        }),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Buy all automatically unlocks level ${blockIndex + 2}',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w100,
                      fontSize: 11,
                      fontStyle: FontStyle.italic),
                )
                // (!productList[0].isVisible)
                //?  Text(
                //     'unlocked level ${blockIndex + 1}',
                //     style: TextStyle(
                //         fontFamily: 'Lato',
                //         fontWeight: FontWeight.w100,
                //         fontSize: 11,
                //         fontStyle: FontStyle.italic),
                //   ),
                )
          ]);
        });
  }

  int getTotalPriceList(List<Product> proList) {
    int total = 0;
    for (var i = 0; i < proList.length; i++) {
      int price2 = int.parse(proList[i].price);
      total = total + price2;
    }
    return total;
  }
}
