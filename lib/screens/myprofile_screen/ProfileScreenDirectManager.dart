import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/profile_manager_screen_bloc/profile_manager_cubit.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class DirectManagerProfileScreen extends StatefulWidget {

  static const routeName = "/direct-manager-profile-screen";
  static const  String employeeHrCode = "managerHrCode";
  static const ContactsDataFromApi selectedContactDataAsMap=const ContactsDataFromApi() ;

  const DirectManagerProfileScreen({Key? key,this.requestData}) : super(key: key);

  final requestData;

  @override
  State<DirectManagerProfileScreen> createState() => DirectManagerProfileScreenClass();
}

class DirectManagerProfileScreenClass extends State<DirectManagerProfileScreen> {


  ScrollController scrollController = ScrollController();

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


    ///Create a new vCard
    VCard vCard = VCard();

    final currentRequestData = widget.requestData;


    return CustomBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                              data: vCard.getFormattedString(),
                              // state is BlocGetManagerDataSuccessState?vCard.getFormattedString():"",

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

          body: BlocProvider<ProfileManagerCubit>(
              create: (context) =>

              currentRequestData[DirectManagerProfileScreen.employeeHrCode] !=
                  "0" ?
              (ProfileManagerCubit()
                ..getManagerData(currentRequestData[DirectManagerProfileScreen
                    .employeeHrCode])) :
              (ProfileManagerCubit()
                ..getUserOffline(currentRequestData[DirectManagerProfileScreen
                    .selectedContactDataAsMap])),

              child: BlocConsumer<ProfileManagerCubit, ProfileManagerState>(
                  listener: (context, state) {
                    if (state is BlocGetManagerDataSuccessState) {

                      print("00-" + state.managerData.toJson().toString());

                      ///Set properties
                      vCard.firstName = state.managerData.name!.toString();
                      vCard.organization = state.managerData.companyName!;
                      // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
                      vCard.jobTitle = state.managerData.titleName!;
                      vCard.email = state.managerData.email!;
                      vCard.url = "https://hassanallam.com";
                      vCard.workPhone = state.managerData.deskPhone;
                      vCard.cellPhone = state.managerData.mobile!;
                    }

                    if (state is BlocGetManagerDataErrorState) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("error"),
                        ),
                      );
                    }
                  },

                  builder: (context, state) {
                    return Container(

                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 15),
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(5.0),

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: IconButton(
                                            icon: const Icon(Icons.phone),
                                            color: Colors.white,
                                            onPressed: () {
                                              UrlLauncher.launch(
                                                  'tel:+${getMobile(state)}');
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: state is BlocGetManagerDataSuccessState &&
                                                  state.managerData
                                                      .imgProfile != null &&
                                                  state.managerData.imgProfile
                                                      .toString() != "" ?
                                              CachedNetworkImage(
                                                imageUrl: "https://portal.hassanallam.com/Apps/images/Profile/${state
                                                    .managerData.imgProfile}",
                                                imageBuilder: (context,
                                                    imageProvider) =>
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                placeholder: (context, url) =>
                                                    Assets.images.logo.image(
                                                        height: 70),
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Assets.images.logo.image(
                                                        height: 70),
                                              ) :
                                              Assets.images.logo.image(
                                                  height: 70),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: IconButton(
                                            icon: const Icon(Icons.mail),
                                            color: Colors.white,
                                            onPressed: () {
                                              UrlLauncher.launch(
                                                  'mailto:${getEmail(state)}');
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.black26,

                                      ),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            width: double.infinity,

                                            child: Text(
                                              state is BlocGetManagerDataSuccessState
                                                  ? state.managerData.name!
                                                  : "",

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
                                          state is BlocGetManagerDataSuccessState
                                              ? state.managerData.titleName!
                                              : "",
                                        ),
                                        getFirstSection(
                                          'HRCode: ${state is BlocGetManagerDataSuccessState
                                              ? state.managerData.userHrCode!
                                              : ""}',
                                        ),

                                      ]),
                                    ),


                                  ],),


                              ),

                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.all(
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
                                            getLine(
                                                state is BlocGetManagerDataSuccessState
                                                    ? state.managerData
                                                    .projectName!
                                                    : ""),

                                            getHead("Job Title:"),
                                            getLine(
                                                state is BlocGetManagerDataSuccessState
                                                    ? state.managerData
                                                    .titleName!
                                                    : ""),

                                            getHead("Email:"),
                                            getLine(
                                                state is BlocGetManagerDataSuccessState
                                                    ? state.managerData.email!
                                                    : ""),

                                            Container(
                                                width: double.infinity,
                                                child: InkWell(
                                                  onTap: () {
                                                    scrollController.animateTo(
                                                        scrollController
                                                            .position
                                                            .minScrollExtent,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease);
                                                    BlocProvider.of<
                                                        ProfileManagerCubit>(
                                                        context).getManagerData(
                                                        state is BlocGetManagerDataSuccessState
                                                            ? state.managerData
                                                            .managerCode!  :
                                                  "  state.managerData"
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        flex: 6,
                                                        child: Column(
                                                            children: [
                                                              getHead(
                                                                  "Direct Manager:"),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 15,
                                                                    right: 3,
                                                                    top: 3,
                                                                    bottom: 3),
                                                                child: Container(
                                                                    width: double
                                                                        .infinity,
                                                                    child: getManagerCodeText(
                                                                        state is BlocGetManagerDataSuccessState
                                                                            ? state
                                                                            .managerData.managerCode
                                                                            .toString()
                                                                            : "")
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .navigate_next_rounded,
                                                          color: Colors.white,
                                                          size: 40.0,),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),

                                            getHead("Mobile Number:"),
                                            getLine(getMobile(state)),

                                            getHead("Ext:"),
                                            getLine(getExt(state)),
                                          ])
                                  )
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }
              )
          )
      ),

    );
  }

  String getEmail(ProfileManagerState state){
    if(state is BlocGetManagerDataSuccessState){
      if(state.managerData.email==null){
        return "";
      }else{
        return state.managerData.email!;
      }
    }
    else{
      return "";
    }
  }

  String getMobile(ProfileManagerState state){
    if(state is BlocGetManagerDataSuccessState){
      if(state.managerData.mobile==null){
        return "";
      }else{
        return state.managerData.mobile!;
      }
    }
    else{
      return "";
    }
  }
  String getExt(ProfileManagerState state){
    if(state is BlocGetManagerDataSuccessState){
      if(state.managerData.deskPhone==null){
        return "";
      }else{
        return state.managerData.deskPhone!;
      }
    }
    else{
      return "";
    }
  }

  Padding getFirstSection(String line) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
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
      child: Container(
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

  Text getManagerCodeText(String managerCode) {
    return Text(
        managerCode,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontFamily: 'Nunito',
          decoration: TextDecoration
              .underline,),
        textAlign: TextAlign.left);
  }

  Padding getLine(String line) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 3, top: 3, bottom: 3),
      child: Container(
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