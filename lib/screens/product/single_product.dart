import 'dart:io';
import 'dart:ui';
import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_event.dart';
import 'package:purchasing_lanka_international/bloc/product_bloc.dart';
import 'package:purchasing_lanka_international/bloc/product_event.dart';
import 'package:purchasing_lanka_international/models/cart_add_item.dart';
import 'package:purchasing_lanka_international/screens/loading/loading.dart';
import 'package:purchasing_lanka_international/screens/product/products_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleProduct extends StatefulWidget {
  final productId;
  final productName;
  final productPicture;
  final productPrice;
  final categoreName;
  final attributes;
  final defaultAttributr;
  final inCart;
  final inLevel;
  final cartItemQuentity;
  final description;

  SingleProduct(
      {this.productId,
      this.productName,
      this.productPicture,
      this.productPrice,
      this.categoreName,
      this.attributes,
      this.inCart,
      this.inLevel,
      this.cartItemQuentity,
      this.defaultAttributr,
      this.description});
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  bool productLoded = false;

  @override
  void initState() {
    super.initState();
    if (productLoded) {
      BlocProvider.of<HomeBloc>(context).add(ProductLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    var homeBlockContex = BlocProvider.of<HomeBloc>(context);
    return InkWell(
      child: buildProduct(context),
      onTap: () {
        if (widget.inLevel) {
          Route route = MaterialPageRoute(
              builder: (context) => ProductDetails(
                    productDetailsId: widget.productId,
                    productDetailsName: widget.productName,
                    productDetailsPicture: widget.productPicture,
                    productDetailsPrice: widget.productPrice,
                    productDetailsCategoreName: widget.categoreName,
                    productDetailsCartItemQuentity: widget.cartItemQuentity,
                    productDetailsAttributes: widget.attributes,
                    productDetailsDefaultAttr: widget.defaultAttributr,
                    productDetailsDescription: widget.description,
                    contextHome: homeBlockContex,
                  ));
          Navigator.push(context, route);
          productLoded = true;
        }
      },
    );
  }

  Widget buildProduct(BuildContext context) {
    if (widget.inLevel) {
      bool cartVisibility = widget.inCart;
      return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      child: Image.network(
                    widget.productPicture[0].src,
                    fit: BoxFit.fill,
                  )),
                  // child: Image.network(productPicture.images[0].src,
                  //     fit: BoxFit.fill),

                  Container(
                    height: 310,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black54
                            ],
                            stops: [
                              0.0,
                              1.0
                            ])),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 210,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black54
                            ],
                            stops: [
                              0.0,
                              1.0
                            ])),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("\$${widget.productPrice}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                  GestureDetector(
                      child: (cartVisibility)
                          ? Visibility(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      // icon: Icon(Icons.card_travel),
                                      icon: Icon(MdiIcons.cartOutline),
                                      onPressed: () {
                                        CartAddItem itemDetails =
                                            new CartAddItem(widget.productId, 1,
                                                widget.attributes);
                                        BlocProvider.of<NavBloc>(context).add(
                                            AddItemButtonPressed(itemDetails));
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(ProductLoading());

                                        setState(() {
                                          cartVisibility = true;
                                        });
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  Duration(seconds: 3), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return Center(
                                                child: new SizedBox(
                                                  height: 50.0,
                                                  width: 50.0,
                                                  child: new CircularProgressIndicator(
                                                      value: null,
                                                      valueColor:
                                                          new AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.amber)
                                                      // strokeWidth: 7.0,
                                                      ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                    Positioned(
                                      top: 5.0,
                                      right: 5.0,
                                      child: Center(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 18,
                                          width: 18,
                                          child: new Text(
                                            '${widget.cartItemQuentity}',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              visible: true,
                            )
                          : Visibility(
                              child: IconButton(
                                icon: Icon(MdiIcons.plus),
                                iconSize: 20,
                                onPressed: () {
                                  CartAddItem itemDetails = new CartAddItem(
                                      widget.productId, 1, widget.attributes);
                                  BlocProvider.of<NavBloc>(context)
                                      .add(AddItemButtonPressed(itemDetails));
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(ProductLoading());
                                  // sleep(const Duration(seconds: 3));
                                  setState(() {
                                    cartVisibility = true;
                                  });
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return Center(
                                          child: new SizedBox(
                                            height: 50.0,
                                            width: 50.0,
                                            child: new CircularProgressIndicator(
                                                value: null,
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                        Color>(Colors.amber)
                                                // strokeWidth: 7.0,
                                                ),
                                          ),
                                        );
                                      });
                                },
                              ),
                              visible: true,
                            )),
                ],
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lato',
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          image: DecorationImage(
            image: NetworkImage(widget.productPicture[0].src),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: prefix0.ImageFilter.blur(
            sigmaX: 2,
            sigmaY: 2,
          ),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
      );
    }
  }
}
