import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';

Widget errorContainer(Function onPressed, String message) {
  return Center(
    child: TextButton(
        onPressed: () {
          onPressed;
        },
        child: Text(message)),
  );
}

Widget noDataFoundContainer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Assets.images.noSearchIcon.image(color: Colors.white, scale: 5),
      const Text('No Data Found',
          style: TextStyle(
              color: Colors.white,
              fontFamily: FontFamily.robotoCondensed,
              fontSize: 25,
              fontWeight: FontWeight.normal)),
    ],
  );
}
