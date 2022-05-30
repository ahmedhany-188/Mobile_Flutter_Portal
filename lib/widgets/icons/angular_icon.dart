import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as p;


createAngularIcon(
    {required String angularIcon,
      required bool solid,
      required BuildContext context,
      Color? color,
      double? size = 40}) {
  var x = angularIcon.split(':');
  final path = p.join(
    'packages/heroicons/assets/${solid ? 'solid' : 'outline'}',
    x[1],
  );
  return SvgPicture.asset(
    '$path.svg',
    color: color ?? IconTheme.of(context).color,
    width: size,
    height: size,
    alignment: Alignment.center,
    theme: const SvgTheme(
      fontSize: 10,
    ),
  );
}