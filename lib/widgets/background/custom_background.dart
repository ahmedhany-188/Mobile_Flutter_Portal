import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'heroBackgroundTag',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.defaultBg.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
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
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white,),
        unselectedWidgetColor: Colors.white70,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0F3C5B),
          secondary: const Color(0xff0F3C5B),
          primary: Colors.white70,
          // primary: Colors.white30

        ),
        // primaryColor: Colors.white30,
        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white30)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)
          ),
        ),
      ),
      child: child,
    );
  }
}
