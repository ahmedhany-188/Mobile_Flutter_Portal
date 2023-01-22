import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hassanallamportalflutter/screens/webview_screen/webview_controls.dart';
import 'package:hassanallamportalflutter/screens/webview_screen/webview_stack.dart';

class WebViewScreen extends StatefulWidget {

  static const routeName = "/webview-screen";
  static const String webURL = "webURL";
  const WebViewScreen({Key? key,this.requestData}) : super(key: key);

  final dynamic requestData;

  @override
  State<WebViewScreen> createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    final currentRequestData = widget.requestData;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ConstantsColors.backgroundStartColor)
      ..loadRequest(
        Uri.parse(currentRequestData[WebViewScreen.webURL]),
      );


    return Scaffold(
      appBar: AppBar(
        title: const Text('HAH'),
        actions: [
          NavigationControls(controller: controller),
        ],
      ),
      body: WebViewStack(
        controller: controller,
      ),
    );
  }
}