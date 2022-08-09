import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.defaultBg.image().image,
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
