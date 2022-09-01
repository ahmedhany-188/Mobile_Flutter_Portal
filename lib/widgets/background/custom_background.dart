import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../gen/assets.gen.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ConstantsColors.backgroundStartColor,
                    ConstantsColors.backgroundEndColor,
                  ],
                )),
              ),
            ),
            Container(
              child: Assets.images.mainBackground.image(),
            )
          ],
        ),
        Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: Assets.images.defaultBg.image().image,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: child,
        )
      ],
    );
  }
}

class CustomTheme extends StatelessWidget {
  const CustomTheme({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: Colors.white,
        highlightColor: Colors.white70,
        disabledColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
        unselectedWidgetColor: Colors.white70,
        canvasColor: ConstantsColors.bottomSheetBackground,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            elevation: 0, color: Colors.transparent, centerTitle: true),
        splashColor: Colors.transparent,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0F3C5B),
          secondary: const Color(0xff0F3C5B),
          background: const Color(0xFF031A27),
          primary: Colors.white70,
        ),
        // popupMenuTheme: const PopupMenuThemeData(color: ConstantsColors.bottomSheetBackgroundDark,shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(20),
        //   ),
        // ),),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
          modalBackgroundColor: ConstantsColors.bottomSheetBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        ),
        // primaryColor: Colors.white30,
        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white30)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
        ),
      ),
      child: child,
    );
  }
}
