import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double latitude, double longitude) async {
// String googleUrl ='https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  String appleUrl = 'https://maps.apple.com/?sll=$latitude,$longitude';
  String googleUrl =
      'https://www.google.com/maps/dir/?api=1&origin=30.1074108,31.3818438&destination=$latitude,$longitude&travelmode=driving&dir_action=navigate';

  if (Platform.isIOS) {
    if (await canLaunch(appleUrl)) {
      await launch(appleUrl);
    } else {
      throw 'Could not open the map.';
    }
  } else {
    /// any platform apart from IOS
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  /// /// other way to be done
  /// String goo = 'comgooglemaps://?center=$latitude, $longitude';
  /// if (await canLaunch("comgooglemaps://")) {
  ///   print('launching com googleUrl');
  ///   await launch(googleUrl);
  /// } else if (await canLaunch(appleUrl)) {
  ///   print('launching apple url');
  ///   await launch(appleUrl);
  /// } else {
  ///   throw 'Could not launch url';
  /// }
}
