import 'package:flutter/material.dart';

Future<DateTime?> openShowDatePicker(context) async{
  // if (defaultTargetPlatform == TargetPlatform.macOS ||
  //     defaultTargetPlatform == TargetPlatform.iOS) {
  // await showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext builder) {
  //       return Container(
  //         height: MediaQuery.of(context).copyWith().size.height * 0.35,
  //         color: const Color.fromARGB(255, 255, 255, 255),
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               height: MediaQuery.of(context).copyWith().size.height * 0.25,
  //               child: CupertinoDatePicker(
  //                 initialDateTime: DateTime.now(),
  //                 onDateTimeChanged: (value) {
  //                   date = value;
  //                 },
  //               ),
  //             ),
  //             CupertinoButton(
  //               child: const Text('OK'),
  //               onPressed: () => Navigator.of(context).pop(),
  //             )
  //           ],
  //         ),);
  //
  //       //   height: MediaQuery.of(context).copyWith().size.height * 0.25,
  //       //   color: Colors.white,
  //       //   child: CupertinoDatePicker(
  //       //     mode: CupertinoDatePickerMode.date,
  //       //     onDateTimeChanged: (value) {
  //       //       date = value;
  //       //     },
  //       //     initialDateTime: DateTime.now(),
  //       //     minimumYear: 2020,
  //       //     maximumYear: 2100,
  //       //   ),
  //       // );
  //     });
  return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context)
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

Future<TimeOfDay?> openShowTimePicker(context)async{
  // if (defaultTargetPlatform == TargetPlatform.macOS ||
  //     defaultTargetPlatform == TargetPlatform.iOS){
  //   await showCupertinoModalPopup(
  //       context: context,
  //       builder: (BuildContext builder) {
  //         return Container(
  //           height: MediaQuery.of(context).copyWith().size.height * 0.25,
  //           color: Colors.white,
  //           child: CupertinoDatePicker(
  //             mode: CupertinoDatePickerMode.time,
  //             onDateTimeChanged: (value) {
  //               time = TimeOfDay.fromDateTime(value);
  //             },
  //             initialDateTime: DateTime.now(),
  //             minimumYear: 2020,
  //             maximumYear: 2100,
  //           ),
  //         );
  //       });
  // }
  // else{
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