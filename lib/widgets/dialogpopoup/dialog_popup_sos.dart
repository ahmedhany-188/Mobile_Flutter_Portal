import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';
import 'package:hassanallamportalflutter/screens/sos_screen/sos_alert_screen.dart';

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
          .height * 0.25,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),),
        color: ConstantsColors.bottomSheetBackgroundDark,
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("HAH SOS",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800,
                    fontSize: 20.0, fontFamily: FontFamily.robotoCondensed),),
            ),
            sizeZoomBoxRequest(context),

          ]),
    );
  }

  Padding sizeZoomBoxRequest(context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 2.0),
                blurRadius: 8.0,
                spreadRadius: 2.0)
          ],
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                "Send Emergency Message",
                style: const TextStyle(color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                softWrap: false,
              ),
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () async {
                    Navigator.of(context).pushNamed(SOSAlertScreen.routeName);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

}