import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {Key? key, required this.text, required this.routName, required this.requestName})
      : super(key: key);
  final String text;
  final String routName;
  final String requestName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Icon(Icons.tag_faces, size: 100),
    //         const SizedBox(height: 10),
    //         Text(
    //           text,
    //           style: const TextStyle(fontSize: 54, color: Colors.black),
    //           textAlign: TextAlign.center,
    //         ),
    //         const SizedBox(height: 10),
    //         ElevatedButton.icon(
    //           onPressed: () => Navigator.of(context).popAndPushNamed(routName,arguments: {'request-No': '0'}),
    //           icon: const Icon(Icons.replay),
    //           label: Text('Create Another $requestName Request'),
    //         ),
    //         ElevatedButton.icon(
    //           onPressed: () => Navigator.pop(context),
    //           icon: const Icon(Icons.close),
    //           label: const Text('Close'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 100, color: Colors.white),
              // child: Image.asset(
              //   "assets/card.png",
              //   fit: BoxFit.contain,
              // ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "$requestName Request Done Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            Text(
              "Request Number is $text",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // Text(
            //   "You will be redirected to the home page shortly\nor click here to return to home page",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.black54,
            //     fontWeight: FontWeight.w400,
            //     fontSize: 14,
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.06),

            GestureDetector(
              onTap: () => Navigator.of(context).popAndPushNamed(routName,arguments: {'request-No': '0'}),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: Text(
                    "Recreate another request",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            // Flexible(
            //   child: HomeButton(
            //     title: 'Home',
            //     onTap: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}