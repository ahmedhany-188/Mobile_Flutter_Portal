import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/myprofile_screen/ProfileScreenDirectManager.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
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

  late final dynamic user;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery
    //     .of(context)
    //     .size
    //     .width;
    // double height = MediaQuery
    //     .of(context)
    //     .size
    //     .height;

    final user = context.select((AppBloc bloc) => bloc.state.userData);


    var imageProfile = user.employeeData?.imgProfile ?? "";

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

    return CustomBackground(

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('My Profile'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 15),
            child: Column(
              children: [

                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.transparent,
                                    onPressed: () {},
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child:  imageProfile.isNotEmpty ? CachedNetworkImage(
                                        imageUrl: "https://portal.hassanallam.com/Apps/images/Profile/${user.employeeData!.imgProfile}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider, fit: BoxFit.cover),
                                            ),
                                          ),
                                        placeholder: (context, url) => Assets.images.logo.image(height: 70),
                                        errorWidget: (context, url, error) => Assets.images.logo.image(height: 70),
                                      ) :
                                      Assets.images.logo.image(height: 70),
                                      ),
                                    ),
                                  ),

                                Flexible(
                                  flex: 2,
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.white,
                                    onPressed: () {
                                      showModalBottomSheet<void>(context: context,shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),),
                                      ),
                                          builder: (BuildContext context) {
                                            return ShowUserProfileBottomSheet(user);
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.black
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5)),
                                color: Colors.black26,

                              ),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: double.infinity,

                                    child: Text(
                                      user.employeeData!.name!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito',
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),

                                getFirstSection(
                                    user.employeeData!.titleName!.toString()),
                                getFirstSection('HRCode: ${user.employeeData!.userHrCode!}'),
                                getFirstSection('Grade: ${user.employeeData!.gradeName}'),

                              ]),
                            ),

                          ],
                        ),

                      ],
                    )
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Colors.black
                      ),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5)),
                      color: Colors.black26,
                    ),

                    child: Column(
                      children: [

                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'My Info',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(
                          thickness: 2.5,
                        ),

                        getHead("Department:"),
                        getLine(user.employeeData!.projectName!),

                        getHead("Job Title:"),
                        getLine(user.employeeData!.titleName!),

                        getHead("Email:"),
                        getLine(user.employeeData!.email!),

                        SizedBox(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    DirectManagerProfileScreen.routeName,
                                    arguments: {
                                      DirectManagerProfileScreen
                                          .employeeHrCode: user
                                          .employeeData!
                                          .managerCode});
                              },
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: Column(
                                        children: [
                                          getHead("Direct Manager:"),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 3,
                                                top: 3,
                                                bottom: 3),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                user.employeeData!.managerName!,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  decoration: TextDecoration
                                                      .underline,),
                                                textAlign: TextAlign.left,),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  const Flexible(
                                    flex: 1,
                                    child: Icon(Icons.navigate_next_rounded,
                                      color: Colors.white,size: 40.0,),
                                  ),
                                ],
                              ),
                            )
                        ),

                        getHead("Mobile Number:"),
                        getLine(user.employeeData!.mobile!),

                        getHead("Ext:"),
                        getLine(user.employeeData!.deskPhone!),
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

  Padding getFirstSection(String line) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          line, style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'Nunito',
        ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Padding getHead(String head) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          head, style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: 'Nunito',
        ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Padding getLine(String line) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 3, top: 3, bottom: 3),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          line, style: const TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontFamily: 'Nunito',
        ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

}


