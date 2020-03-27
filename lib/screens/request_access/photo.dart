import 'package:flutter/material.dart';

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              // child: Image.file(File(imagePath)),
              child: Image.network(
            'https://picsum.photos/250?image=9',
            fit: BoxFit.fitWidth,
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text('Back to Cam'),
                        color: Colors.transparent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(12),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text('Select Photo'),
                        color: Colors.transparent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(12),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.white)),
                      ),
                    ),
                    // SizedBox(height: 15.0),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
