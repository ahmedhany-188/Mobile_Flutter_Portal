

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';

class DialogSOSMainBottomSheet extends StatelessWidget {
  const DialogSOSMainBottomSheet({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 30),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.30,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
        decoration: const BoxDecoration(
          color: ConstantsColors.bottomSheetBackgroundDark,
          // borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        child: Column(
            children: const [
               Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("HAH SOS",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,
                      fontSize: 20.0,fontFamily: FontFamily.robotoCondensed),),
              ),
              ]),
    );
  }

}