import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_event.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              child: Image.file(
            File(imagePath),
            fit: BoxFit.fitWidth,
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                        onPressed: () {
                          setReceiptImageToPref(imagePath);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
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
