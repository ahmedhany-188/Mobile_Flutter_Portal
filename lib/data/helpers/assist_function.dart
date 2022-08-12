import 'package:flutter/material.dart';

Widget titleText(String titleName) {
  return Text(
    titleName,
    style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 18,
        decoration: TextDecoration.underline,color: Colors.white),
  );
}
Widget paragraphText(String paragraph) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(
      paragraph,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15,color: Colors.white),
    ),
  );
}

SizedBox addPaddingWhenKeyboardAppears() {
  final viewInsets = EdgeInsets.fromWindowPadding(
    WidgetsBinding.instance.window.viewInsets,
    WidgetsBinding.instance.window.devicePixelRatio,
  );

  final bottomOffset = viewInsets.bottom ;
  const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
  final isNeedPadding = bottomOffset != hiddenKeyboard;

  return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
}

showErrorSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('Something went wrong'),
  ));
}

checkTimeAmPm(){
  return DateTime.now().isBefore(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      12,
      00,
    ),
  );
}