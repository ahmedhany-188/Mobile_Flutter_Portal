import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SOSAlertScreen extends StatefulWidget {

  static const routeName = "/sos-alert-screen";

  const SOSAlertScreen({Key? key,})
      : super(key: key);

  @override
  State<SOSAlertScreen> createState() => SOSAlertScreenClass();
}

  class SOSAlertScreenClass extends State<SOSAlertScreen> {

    bool hold=false;

    @override
    Widget build(BuildContext context) {
      final user = context.select((AppBloc bloc) => bloc.state.userData);

      return CustomBackground(
          child: Scaffold(
            // drawer: MainDrawer(),
            // appBar: internalAppBar(context: context, title: 'Subsidiaries'),
            appBar: AppBar(
              centerTitle: true,
              title: const Text('HAH SOS'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Ink(
                      decoration: const ShapeDecoration(
                        color: ConstantsColors.backgroundStartColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          color: ConstantsColors.whiteNormalAttendance,
                        ),
                        iconSize: 150.0,
                        splashColor: ConstantsColors.redAttendance,
                        padding: const EdgeInsets.all(40.0),
                        onPressed: () async {

                          if(!hold){
                            hold=true;
                            bool serviceEnabled;
                            LocationPermission permission;
                            serviceEnabled = await Geolocator.isLocationServiceEnabled();
                            if (!serviceEnabled) {
                              // return Future.error('Location services are disabled.');
                              Geolocator.requestPermission();
                            }
                            permission = await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied) {
                              permission = await Geolocator.requestPermission();
                              if (permission == LocationPermission.denied) {
                                hold=false;
                                return Future.error('Location permissions are denied');
                              }
                            }
                            if (permission == LocationPermission.deniedForever) {
                              hold=false;
                              return Future.error(
                                  'Location permissions are permanently denied, we cannot request permissions.');
                            }

                            EasyLoading.show(
                              status: 'loading...',
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: false,
                            );

                            try {
                              Position position=await Geolocator.getCurrentPosition();
                              if (position != null) {

                                hold=false;
                                await EasyLoading.dismiss(animation: true);
                                getsms(position.latitude, position.longitude,
                                    user.employeeData?.name ?? "",
                                    user.employeeData?.userHrCode ?? "");
                              }
                            }catch(ex) {
                              Fluttertoast.showToast(
                                  msg: "unfortunately, failed to get location",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );

                              await EasyLoading.dismiss(animation: true);
                              hold=false;
                            }
                          }
                        },
                      )),
                  const Padding(
                    padding: EdgeInsets.all(25.0),),
                  const Text(
                    "Send Emergency Alert.",
                    style: TextStyle(
                        color: ConstantsColors.whiteNormalAttendance,
                        fontSize: 22.2,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )

          )
      );
    }

    void getsms(lat,long,String name,String hrCode) async {

      // String message = "Hi my name is : ----- .\nHrCode: -----.\nLocation is: https://www.google.com/maps/search/?api=1&query=${lat}%2C${long}";
      // List<String> recipents = ["+201141789961"];
      String uri = 'sms:+20 1141789961?body=Hi my name is:'+name+',HrCode: '+hrCode+',\nmy location is: https://www.google.com/maps/search/?api=1%26query='+lat.toString()+'%20'+long.toString();
      print("\n--"+uri.toString());

      if (true) {
        await launchUrl(Uri.parse(Uri.encodeFull(uri)));
        await EasyLoading.dismiss(animation: true);
      } else {
        // iOS
        const uri = 'sms:20 1141789961';
        if (await launchUrl(Uri.parse(uri))) {
          await EasyLoading.dismiss(animation: true);
          await launchUrl(Uri.parse(uri));
        } else {
          throw 'Could not launch $uri';
        }
      }
      await EasyLoading.dismiss(animation: true);
    }
    // void _sendSMS(String message, List<String> recipents) async {
    //   String _result = await sendSMS(message: message, recipients: recipents)
    //       .catchError((onError) {
    //     print(onError);
    //   });
    //   print(_result);
    // }
  }
