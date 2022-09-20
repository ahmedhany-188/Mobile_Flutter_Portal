import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';

Future<DateTime?> openShowDatePicker(context) async {
  if (defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    return await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height * 0.35,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: const Text('Cancel', style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black, fontSize: 20),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: const Text('Done', style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black, fontSize: 20),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .copyWith()
                      .size
                      .height * 0.25,
                  // child: CupertinoTheme(
                  //   data: const CupertinoThemeData(
                  //     textTheme: CupertinoTextThemeData(
                  //       dateTimePickerTextStyle: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    minimumYear: 2020,
                    maximumYear: 2100,
                    onDateTimeChanged: (value) {
                      // date = value;
                      print("----date picker-----" + value.toString());
                    },
                  ),
                ),
                // ),
              ],
            ),);
        });

    // ---------------------------------------------------
  } else {
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .apply(bodyColor: const Color(0xff0F3C5B),),
              colorScheme: const ColorScheme.light(
                primary: Color(0xff0F3C5B), // header background color
                onPrimary: Colors.white, // header text color
                // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color(0xff0F3C5B), // button text color
                ),
              ),
            ),
            child: child!,
          );
        }
    );
  }
}
Future<TimeOfDay?> openShowTimePicker(context)async {
  if (defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.iOS){
  return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.35,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: const Text('Cancel',style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black, fontSize: 20),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: const Text('Done',style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black, fontSize: 20),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
                color: Colors.black38,
              ),
              SizedBox(
                height: MediaQuery.of(context).copyWith().size.height * 0.25,
                // child: CupertinoTheme(
                //   data: const CupertinoThemeData(
                //     textTheme: CupertinoTextThemeData(
                //       dateTimePickerTextStyle: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),

                  onDateTimeChanged: (value) {
                    // date = value;
                    print("----date picker-----" + value.toString());
                  },
                ),
              ),
              // ),
            ],
          ),);
      });

  //------------------------------

  }
  else{
  return await showTimePicker(context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .apply(bodyColor: const Color(0xff0F3C5B),),
              colorScheme: const ColorScheme.light(
                primary: Color(0xff0F3C5B), // header background color
                onPrimary: Colors.white, // header text color
                // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color(0xff0F3C5B), // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
}
}