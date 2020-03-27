import 'dart:io';
import 'package:flutter/material.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

class ImageSlot extends StatelessWidget {
  final i;
  ImageSlot(this.i);

  @override
  Widget build(BuildContext context) {
    var value = i;
    if (value == 2) {
      String imgPath = getImageFromPref();
      return Container(
          height: 110,
          width: MediaQuery.of(context).size.width,
          child: Image.file(File(imgPath)));
    }
  }

  getImageFromPref() async {
    String imagePath = await getReceiptImageFromPref();
  }
}
