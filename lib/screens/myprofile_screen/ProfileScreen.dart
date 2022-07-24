import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/contacts_screen_bloc/contacts_cubit.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';


class UserProfileScreen extends StatefulWidget {

  static const routeName = "/my-profile-screen";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => UserProfileScreenClass();
}

class UserProfileScreenClass extends State<UserProfileScreen> {

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
    VCard vCard=VCard();

    ///Set properties
    vCard.firstName = user.employeeData!.name!;
    vCard.organization = user.employeeData!.companyName!;
    // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
    vCard.jobTitle = user.employeeData!.titleName!;
    vCard.email = user.employeeData!.email!;
    vCard.url = "https://hassanallam.com";
    vCard.workPhone = user.employeeData!.deskPhone!;
    vCard.cellPhone = user.employeeData!.mobile;



    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),

      // drawer: MainDrawer(),

      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(

          image: DecorationImage(
            image: AssetImage("assets/images/S_Background.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              children: [

                Container(
                  height: height * 0.70,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.85,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  Text(
                                    user.employeeData!.name!,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontFamily: 'Nunito',
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  Text(
                                    user.employeeData!.titleName!.toString(),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontFamily: 'Nunito',
                                      fontSize: 15,
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'HRCode ',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontFamily: 'Nunito',
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            user.employeeData!.userHrCode!
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  39, 105, 171, 1),
                                              fontFamily: 'Nunito',
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Grade',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontFamily: 'Nunito',
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            user.employeeData!.gradeName
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  39, 105, 171, 1),
                                              fontFamily: 'Nunito',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  QrImage(
                                      // data: user.employeeData!.name
                                      //   .toString()+"\n"+user.employeeData!.titleName
                                      //   .toString()+"\n"+user.employeeData!.companyName
                                      // .toString(),
                                    data:vCard.getFormattedString(),
                                    version: QrVersions.auto,
                                    size: width*0.40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 110,
                            right: 20,

                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.grey[700],
                              onPressed: () {
                                showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return const DialogPopUpUserProfile();
                                    }
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    "https://portal.hassanallam.com/Apps/images/Profile/${user
                                        .employeeData!.userHrCode!}.jpg"),
                                radius: 70,

                              ),
                            ),
                          ),

                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: height * 0.65,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'My Info',
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontSize: 20,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const Divider(
                          thickness: 2.5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          child: Text(
                            'Department: \n${user.employeeData!.projectName!}',

                            style: const TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),

                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          child: Text(
                            'Job Title: \n${user.employeeData!.titleName!}',
                            style: const TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          child: Text(
                            'Email: \n${user.employeeData!.email!}',
                            style: const TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          child: Text(
                            'Direct Manager: \n${user.employeeData!
                                .managerCode!}',
                            style: const TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          child: Text(
                            'Mobile Number: \n${user.employeeData!.mobile!}',
                            style: const TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          child: Text(
                            'Ext: \n' + user.employeeData!.deskPhone!,
                            style: const TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
