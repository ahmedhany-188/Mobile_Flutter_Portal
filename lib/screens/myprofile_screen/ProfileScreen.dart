import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreenDirectManager.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

class UserProfileScreen extends StatefulWidget {

  static const routeName = "/my-profile-screen";
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => UserProfileScreenClass();
}

class UserProfileScreenClass extends State<UserProfileScreen> {

  late final user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    ///Create a new vCard
    VCard vCard = VCard();

    ///Set properties
    vCard.firstName = user.employeeData!.name!;
    vCard.organization = user.employeeData!.companyName!;
    // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
    vCard.jobTitle = user.employeeData!.titleName!;
    vCard.email = user.employeeData!.email!;
    vCard.url = "https://hassanallam.com";
    vCard.workPhone = user.employeeData!.deskPhone!;
    vCard.cellPhone = user.employeeData!.mobile;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.defaultBg.image().image,
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('My Profile'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.qr_code,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                showDialog(context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),

                          child: QrImage(
                            data: vCard
                                .getFormattedString(),
                            version: QrVersions.auto,
                            backgroundColor: Colors.white,
                          ),

                        ),

                      );
                    }
                );
              },
            )
          ],
        ),

        resizeToAvoidBottomInset: false,
        body: Container(


          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 30),
              child: Column(
                children: [


                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundImage:
                                          NetworkImage(
                                              "https://portal.hassanallam.com/Apps/images/Profile/${user
                                                  .employeeData!
                                                  .userHrCode!}.jpg"),
                                          radius: 70,
                                        ),
                                      ),
                                    ),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        user.employeeData!.name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        user.employeeData!.titleName!
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'HRCode: ' + user.employeeData!
                                            .userHrCode!
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Grade: ' + user.employeeData!
                                            .gradeName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                          ]),
                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 30,
                                  right: 30,
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.white,
                                    onPressed: () {
                                      showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return const DialogPopUpUserProfile();
                                          }
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                  ),
                ),


                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8),

                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),

                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: const Text(
                                'My Info',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 2.5,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Department: \n   ${user.employeeData!
                                      .projectName!}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Job Title: \n   ${user.employeeData!
                                      .titleName!}',
                                  style: const TextStyle(
                                    color: Colors.white,

                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Email: \n   ${user.employeeData!.email!}',
                                  style: const TextStyle(
                                    color: Colors.white,

                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          DirectManagerProfileScreen.routeName,
                                          arguments: {
                                            DirectManagerProfileScreen
                                                .employeeHrCode: user.employeeData!
                                                .managerCode
                                          });
                                    },
                                    child: Text(
                                      'Direct Manager: ${user
                                          .employeeData!
                                          .managerCode!}',
                                      style: const TextStyle(
                                        color: Colors.white,

                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        decoration: TextDecoration.underline,),
                                      textAlign: TextAlign.left,),
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Mobile Number: \n   ${user.employeeData!
                                      .mobile!}',
                                  style: const TextStyle(
                                    color: Colors.white,

                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Ext: \n   ' +
                                      user.employeeData!.deskPhone!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),


                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


