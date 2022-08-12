import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
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
                      scale: 1.5,
                    ),
                    const SizedBox.square(
                      dimension: 30,
                    ),
                    titleText('About Our New Mobile Application'),
                    paragraphText(
                        "Now you can navigate easily around the application."
                        "all feature are exactly the same and added some new features."
                        "feel free to inquire about the application throw IT department"),
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                          text: 'See User Manual',
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
                    const Divider(thickness: 3),
                    const Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Text('All rights reserved @ hassan allam',style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
