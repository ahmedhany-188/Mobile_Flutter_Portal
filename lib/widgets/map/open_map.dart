
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double latitude, double longitude) async {
// String googleUrl ='https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  String appleUrl =
      'https://maps.apple.com/?saddr=30.1074108,31.3818438&daddr=$latitude,$longitude';
  String googleUrl =
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving&dir_action=navigate';

  if (Platform.isIOS) {
    if (await canLaunchUrl(Uri.parse(appleUrl))) {
      await launchUrl(Uri.parse(appleUrl));
    } else {
      throw 'Could not open the map.';
    }
  } else {
    /// any platform apart from IOS
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  /// other way to be done
  //  String goo = 'comgooglemaps://?center=$latitude, $longitude';
  // if (await canLaunchUrl(Uri.parse(googleUrl))) {
  //   await launchUrl(Uri.parse(googleUrl),mode: LaunchMode.externalApplication);
  // } else if (await canLaunchUrl(Uri.parse(appleUrl))) {
  //   await launchUrl(Uri.parse(appleUrl),mode: LaunchMode.externalApplication);
  // } else {
  //   throw 'Could not launch url';
  // }
}
