
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter/foundation.dart';

class DialogProfileCallBottomSheet extends StatelessWidget {
  const DialogProfileCallBottomSheet(
      {Key? key, required this.type, required this.value})
      : super(key: key);

  final String type, value;


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
            child: Text("Ways of connections",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,
                  fontSize: 20.0,fontFamily: FontFamily.robotoCondensed),),
          ),
          Row(children: [
            type == "phoneNumber" ? Flexible(
              child: sizeCallBoxRequest(
                  const Icon(
                      Icons.phone,
                      size: 40.0,
                      color: Colors.green
                  ),
                  context, value),
            ) : Text(""),
            Flexible(
              child: sizeZoomBoxRequest(
                  "Zoom",
                  context, value),
            ),
          ]),
        ],
      ),
    );
  }

  Padding sizeCallBoxRequest(Icon requestIcon, BuildContext context, value) {
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
                  url_launcher.launchUrl(Uri.parse('tel:${value}'));
                }
                ),
              ),),
          ],
        ),
      ),
    );
  }


  Padding sizeZoomBoxRequest(String requestType, BuildContext context, value) {
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
                Center(
                  child: Text(
                    requestType,
                    style: const TextStyle(color: Colors.lightBlue, fontSize: 28,fontWeight: FontWeight.w800),
                    softWrap: false,
                  ),
                ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () async {
                  try {
                    Uri url;
                    bool found = await url_launcher.canLaunchUrl(
                        Uri.parse('zoomus://'));
                    if (defaultTargetPlatform == TargetPlatform.macOS ||
                        defaultTargetPlatform == TargetPlatform.iOS) {
                      if (found) {
                        if(type == "phoneNumber"){
                          await Clipboard.setData(ClipboardData(text:value));
                        }else{
                          await Clipboard.setData(ClipboardData(text: "99"+value));
                        }
                        url_launcher.launchUrl(Uri.parse('zoomus://'));
                      } else {
                        url = Uri.parse(
                            "https://apps.apple.com/app/id546505307");
                        url_launcher.launchUrl(url, mode: url_launcher
                            .LaunchMode.externalApplication);
                      }
                    } else {
                      if (found) {
                        if(type == "phoneNumber"){
                          await Clipboard.setData(ClipboardData(text:value));
                        }else{
                          await Clipboard.setData(ClipboardData(text: "99"+value));
                        }
                        url_launcher.launchUrl(Uri.parse('zoomus://'));
                      } else {
                        url = Uri.parse(
                            "https://play.google.com/store/apps/details?id=us.zoom.videomeetings");
                        url_launcher.launchUrl(url, mode: url_launcher
                            .LaunchMode.externalApplication);
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