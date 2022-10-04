import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/helpers/assist_function.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about-screen';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('About'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.images.loginImageLogo.path,
                    scale: 2,
                  ),
                  const Text(
                    'Information Technology Department',
                    style: TextStyle(
                        color: Colors.white, fontSize: 11, letterSpacing: 2),
                  ),
                  const SizedBox.square(
                    dimension: 100,
                  ),
                  // titleText('About Our New Mobile Application'),
                  const Text(
                      "Here an instructions on how to use the mobile application whith this link below.",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                          text: 'User Manual',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunchUrl(Uri.parse(
                                  'https://portal.hassanallam.com/Portal_Mobile_App_user_manual.pdf'))) {
                                launchUrl(
                                    Uri.parse(
                                        'https://portal.hassanallam.com/Portal_Mobile_App_user_manual.pdf'),
                                    mode: LaunchMode.externalApplication);
                                Navigator.defaultRouteName;
                              } else {
                                showErrorSnackBar(context);
                              }
                            }),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                        "Copyright 2020 by HAH IT Department All Rights Reserved. Reproduced or Using this application without being an Hassan Allam Holding's Employees or any of Hassan Allam Subsidiary's Employees is prohibited",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox.square(dimension: 10),
                  FutureBuilder<String>(
                    future: getVersionCode(),
                      builder: (context, snapshot){
                     return Text("Version: ${snapshot.data}",style: const TextStyle(color: Colors.white70),);

                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 Future<String> getVersionCode() async{
   PackageInfo packageInfo = await PackageInfo.fromPlatform();
   String version = packageInfo.version;
  return version;
 }

