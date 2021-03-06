import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_event.dart';

class CatogoryPage extends StatefulWidget {
  @override
  _CatogoryPageState createState() => _CatogoryPageState();
}

class _CatogoryPageState extends State<CatogoryPage> {
  var categories = [
    {
      'title': 'Commodity food items',
      'img': 'assets/catogory/commodity food items.jpg',
    },
    {
      'title': 'Dairy',
      'img': 'assets/catogory/dairy.jpg',
    },
    {
      'title': 'Beens',
      'img': 'assets/catogory/beens.jpg',
    },
    {
      'title': 'Spices',
      'img': 'assets/catogory/spices.jpg',
    },
    {
      'title': 'Vegetables',
      'img': 'assets/catogory/vegetables.jpg',
    },
    {
      'title': 'Brooms',
      'img': 'assets/catogory/brooms.jpg',
    },
    {
      'title': 'Electronics',
      'img': 'assets/catogory/electronics.jpg',
    },
    {
      'title': 'Other Item',
      'img': 'assets/catogory/house.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      drawer: buildDrawer(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: 8,
        itemBuilder: (context, i) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Card(
                elevation: 2,
                child: Container(
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    child: buildTitle(categories[i]['title']),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(categories[i]['img']),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            onTap: () => {
              BlocProvider.of<NavBloc>(context)
                  .add(GoToHomeButtonPressedNav(categories[i]['title'])),
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ProductPage(
              //               title: categories[i]['title'],
              //             )))
            },
          );
        });
  }

  Widget buildTitle(String title) {
    return Center(
      child: Container(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: Colors.white, style: BorderStyle.solid)),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: UserAccountsDrawerHeader(
//              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/mazzad.png"))),
              accountName: Text("Omar Hatem"),
              accountEmail: Text("omarh.ismail1@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/icon/logo.png"),
                radius: 50,
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  buildSeparators("Registeration"),
                  buildTile(
                    "Login",
                    "/login",
                    'assets/icon/login.png',
                  ),
                  buildTile(
                    "SignUp",
                    "/signUp",
                    'assets/icon/registeration_ico.png',
                  ),
                  Divider(),
                  buildSeparators("Help Center"),
                  buildTile(
                    "Feedback",
                    "/feedback",
                    'assets/icon/feedback.png',
                  ),
                  buildTile(
                    "How to order",
                    "/feedback",
                    'assets/icon/info.png',
                  ),
                  buildTile(
                    "Shipping",
                    "/feedback",
                    'assets/icon/shipping.png',
                  ),
                  buildTile(
                    "Questions and Assistance",
                    "/feedback",
                    'assets/icon/assistance.png',
                  ),
                  buildTile(
                    "About payment",
                    "/feedback",
                    'assets/icon/visa.png',
                  ),
                  Divider(),
                  buildSeparators("Public Policy"),
                  buildTile(
                    "Privacy Policy",
                    "/feedback",
                    'assets/icon/policy.png',
                  ),
                  buildTile(
                    "Terms and Conditions",
                    "/feedback",
                    'assets/icon/terms.png',
                  ),
                  buildTile(
                    "Return Policy",
                    "/feedback",
                    'assets/icon/refund.png',
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildSeparators(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          name,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget buildTile(String name, String path, String imgPath) {
    return ListTile(
      leading: Image.asset(
        imgPath,
        scale: 1.2,
      ),
      title: Text(name),
      onTap: () {
        if (path != '/login' && path != '/signUp')
          Navigator.pop(context);
        else
          Navigator.pushNamed(context, path);
      },
    );
  }
}
