import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

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
    return CustomTheme(
      child: Scaffold(
        backgroundColor: ConstantsColors.buttonColors,
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.06),
              Container(
                height: 170,
                padding: const EdgeInsets.all(35),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 100, color: ConstantsColors.buttonColors),
              ),
              SizedBox(height: screenHeight * 0.08),
              const Text(
                "Thank You!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "$requestName Request Done Successfully",
                style: const TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              Text(
                "Request Number is $text",
                style: const TextStyle(
                  color: Colors.white60,
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
                        .highlightColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      "Create another request",
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
                        .highlightColor,
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
            ],
          ),
        ),
      ),
    );
  }
}