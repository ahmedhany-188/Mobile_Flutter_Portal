import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsLetterScreen extends StatelessWidget {
  const NewsLetterScreen({Key? key}) : super(key: key);
  static const routeName = 'news-letter-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News letter'),),
      body: Sizer(builder: (context, orientation, deviceType) {
        return SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(onPressed: (){
                launchUrl(Uri.parse('https://portal.hassanallam.com/NewsLatter/index-ar.html'),mode: LaunchMode.platformDefault);
              }, child: const Text('Arabic News Letter')),
              OutlinedButton(onPressed: (){
                launchUrl(Uri.parse('https://portal.hassanallam.com/NewsLatter/index.html'),mode: LaunchMode.platformDefault);
              }, child: const Text('English News Letter')),
            ],
          ),
        );
      },),
    );
  }
}
