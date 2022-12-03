
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';




class DialogCatalogShareItemBottomSheet extends StatelessWidget {
  const DialogCatalogShareItemBottomSheet({Key? key, required this.value})
      : super(key: key);

  final String value;

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
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Ways of Share",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,
                  fontSize: 20.0, fontFamily: FontFamily.robotoCondensed),),
          ),
          Row(children: [
            Flexible(
              child: sizeCopyLink(
                  const Icon(
                      Icons.copy,
                      size: 40.0,
                      color: Colors.green
                  ),
                  context, value
              ),),
            Flexible(
              child: sizeSendItemWhats(
                  const Icon(
                      Icons.whatsapp,
                      size: 40.0,
                      color: Colors.green
                  ),
                  context, value),
            ),
          ]),
        ],
      ),
    );
  }

  Padding sizeCopyLink(Icon requestIcon, BuildContext context, value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
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
            Align(
              alignment: Alignment.center,
              child: requestIcon,
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () async {
                  await Clipboard.setData(ClipboardData(
                      text: value));
                  EasyLoading.showInfo('Item Link Copied');
                }),
              ),),
          ],
        ),
      ),
    );
  }


  Padding sizeSendItemWhats(Icon requestIcon, BuildContext context, value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
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
            Align(
              alignment: Alignment.center,
              child: requestIcon,
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () async {
                  try {
                    bool found = await url_launcher.canLaunchUrl(
                        Uri.parse('wa.me://'));
                    if (defaultTargetPlatform == TargetPlatform.macOS ||
                        defaultTargetPlatform == TargetPlatform.iOS) {
                      if (found) {
                        // const url = "https://wa.me/?text=Your Message here";
                        // var encoded = Uri.encodeFull(url);
                        // ios
                        // <key>LSApplicationQueriesSchemes</key>
                        // <array>
                        // <string>whatsapp</string>
                        // </array>
                        url_launcher.launchUrl(Uri.parse(
                            'https://wa.me/?text=${Uri.parse(value)}'));
                      } else {
                        EasyLoading.showInfo('App not Found');
                      }
                    } else {
                      if (found) {
                        // const url = "https://wa.me/?text=Your Message here";
                        // var encoded = Uri.encodeFull(url);
                        url_launcher.launchUrl(Uri.parse(
                            'https://wa.me/?text=${Uri.parse(value)}'));
                      } else {
                        EasyLoading.showInfo('App not Found');
                      }
                    }
                  } catch (ex) {
                    print("No data found");
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}