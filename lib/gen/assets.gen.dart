/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Benefits.png
  AssetGenImage get benefits =>
      const AssetGenImage('assets/images/Benefits.png');

  /// File path: assets/images/Builds.png
  AssetGenImage get builds => const AssetGenImage('assets/images/Builds.png');

  /// File path: assets/images/Cover.png
  AssetGenImage get cover => const AssetGenImage('assets/images/Cover.png');

  /// File path: assets/images/Media.png
  AssetGenImage get media => const AssetGenImage('assets/images/Media.png');

  /// File path: assets/images/S_Background.png
  AssetGenImage get sBackground =>
      const AssetGenImage('assets/images/S_Background.png');

  /// File path: assets/images/Subsidiaries.png
  AssetGenImage get subsidiaries =>
      const AssetGenImage('assets/images/Subsidiaries.png');

  /// File path: assets/images/Values.png
  AssetGenImage get values => const AssetGenImage('assets/images/Values.png');

  /// File path: assets/images/backgroundattendance.jpg
  AssetGenImage get backgroundattendance =>
      const AssetGenImage('assets/images/backgroundattendance.jpg');

  /// File path: assets/images/buildings.png
  AssetGenImage get buildings =>
      const AssetGenImage('assets/images/buildings.png');

  /// File path: assets/images/defaultBg.jpg
  AssetGenImage get defaultBg =>
      const AssetGenImage('assets/images/defaultBg.jpg');

  /// File path: assets/images/fulllogoblue.png
  AssetGenImage get fulllogoblue =>
      const AssetGenImage('assets/images/fulllogoblue.png');

  /// File path: assets/images/home_cropped.jpg
  AssetGenImage get homeCropped =>
      const AssetGenImage('assets/images/home_cropped.jpg');

  $AssetsImagesHomepageGen get homepage => const $AssetsImagesHomepageGen();

  /// File path: assets/images/login_image_background.png
  AssetGenImage get loginImageBackground =>
      const AssetGenImage('assets/images/login_image_background.png');

  /// File path: assets/images/login_image_background_two.png
  AssetGenImage get loginImageBackgroundTwo =>
      const AssetGenImage('assets/images/login_image_background_two.png');

  /// File path: assets/images/login_image_buildings.png
  AssetGenImage get loginImageBuildings =>
      const AssetGenImage('assets/images/login_image_buildings.png');

  /// File path: assets/images/login_image_light.png
  AssetGenImage get loginImageLight =>
      const AssetGenImage('assets/images/login_image_light.png');

  /// File path: assets/images/login_image_logo.png
  AssetGenImage get loginImageLogo =>
      const AssetGenImage('assets/images/login_image_logo.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/native_splash.png
  AssetGenImage get nativeSplash =>
      const AssetGenImage('assets/images/native_splash.png');

  /// File path: assets/images/welcomeImage.gif
  AssetGenImage get welcomeImage =>
      const AssetGenImage('assets/images/welcomeImage.gif');
}

class $AssetsImagesHomepageGen {
  const $AssetsImagesHomepageGen();

  /// File path: assets/images/homepage/attendanceIcon.png
  AssetGenImage get attendanceIcon =>
      const AssetGenImage('assets/images/homepage/attendanceIcon.png');

  /// File path: assets/images/homepage/benefitsIcon.png
  AssetGenImage get benefitsIcon =>
      const AssetGenImage('assets/images/homepage/benefitsIcon.png');

  /// File path: assets/images/homepage/contactListIcon.png
  AssetGenImage get contactListIcon =>
      const AssetGenImage('assets/images/homepage/contactListIcon.png');

  /// File path: assets/images/homepage/economyNewsIcon.png
  AssetGenImage get economyNewsIcon =>
      const AssetGenImage('assets/images/homepage/economyNewsIcon.png');

  /// File path: assets/images/homepage/haNewsLetterIcon.png
  AssetGenImage get haNewsLetterIcon =>
      const AssetGenImage('assets/images/homepage/haNewsLetterIcon.png');

  /// File path: assets/images/homepage/hrRequestsIcon.png
  AssetGenImage get hrRequestsIcon =>
      const AssetGenImage('assets/images/homepage/hrRequestsIcon.png');

  /// File path: assets/images/homepage/itRequestIcon.png
  AssetGenImage get itRequestIcon =>
      const AssetGenImage('assets/images/homepage/itRequestIcon.png');

  /// File path: assets/images/homepage/mediaCenterIcon.png
  AssetGenImage get mediaCenterIcon =>
      const AssetGenImage('assets/images/homepage/mediaCenterIcon.png');

  /// File path: assets/images/homepage/newsIcon.png
  AssetGenImage get newsIcon =>
      const AssetGenImage('assets/images/homepage/newsIcon.png');

  /// File path: assets/images/homepage/staffDashboardIcon.png
  AssetGenImage get staffDashboardIcon =>
      const AssetGenImage('assets/images/homepage/staffDashboardIcon.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
