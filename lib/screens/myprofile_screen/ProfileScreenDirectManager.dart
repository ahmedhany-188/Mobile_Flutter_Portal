import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/profile_manager_screen_bloc/profile_manager_cubit.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';


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

  static String assetImage = 'assets/images/logo.png';


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

    final currentRequestData = widget.requestData;


    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.defaultBg
                .image()
                .image,
            fit: BoxFit.cover,
          )),
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

              currentRequestData[DirectManagerProfileScreen.employeeHrCode]!="0"?
              (ProfileManagerCubit()..getManagerData(currentRequestData[DirectManagerProfileScreen.employeeHrCode])):
              (ProfileManagerCubit()..getUserOffline(currentRequestData[DirectManagerProfileScreen.selectedContactDataAsMap])),

              child: BlocConsumer<ProfileManagerCubit, ProfileManagerState>(
                  listener: (context, state) {

                    if (state is BlocGetManagerDataSuccessState) {

                      ///Set properties
                      vCard.firstName = state.managerData.name!.toString();
                      vCard.organization = state.managerData.companyName!;
                      // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
                      vCard.jobTitle = state.managerData.titleName!;
                      vCard.email = state.managerData.email!;
                      vCard.url = "https://hassanallam.com";
                      vCard.workPhone = state.managerData.deskPhone!;
                      vCard.cellPhone = state.managerData.mobile;

                    }

                    // if(state is BlocGetManagerDataSuccessOfflineState){
                    //
                    //   ///Set properties
                    //   vCard.firstName = state.employeeData.name!.toString();
                    //   vCard.organization = state.employeeData.companyName!;
                    //   // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
                    //   vCard.jobTitle = state.employeeData.titleName!;
                    //   vCard.email = state.employeeData.email!;
                    //   vCard.url = "https://hassanallam.com";
                    //   vCard.workPhone = state.employeeData.deskPhone!;
                    //   vCard.cellPhone = state.employeeData.mobile!;
                    //
                    // }

                    if (state is BlocGetManagerDataErrorState) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("error"),
                        ),
                      );                  }
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

                                  child:  Stack(
                                      children: [

                                  Column(
                                  children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: CircleAvatar(
                                              // backgroundImage:
                                              backgroundColor: Colors.transparent,
                                              foregroundImage:  state is BlocGetManagerDataSuccessState ?
                                              NetworkImage("https://portal.hassanallam.com/Apps/images/Profile/"
                                                  "${state.managerData.userHrCode!}.jpg"):
                                              AssetImage(assetImage) as ImageProvider,
                                              radius: 70,
                                            ),
                                          ),
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
                                              state is BlocGetManagerDataSuccessState ?state.managerData.name!:"",

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
                                          state is BlocGetManagerDataSuccessState?state.managerData.titleName!:"",
                                        ),
                                        getFirstSection( 'HRCode: ${state is BlocGetManagerDataSuccessState?state.managerData.userHrCode!:""}',
                                        ),
                                        getFirstSection( 'Grade: ${state is BlocGetManagerDataSuccessState?state.managerData.gradeName.toString():""}',
                                        ),

                                      ]),
                                    ),



                                          ],),

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

                    Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      getLine(state is BlocGetManagerDataSuccessState?state.managerData.projectName!:""),

                      getHead("Job Title:"),
                      getLine(state is BlocGetManagerDataSuccessState?state.managerData.titleName!:""),

                      getHead("Email:"),
                      getLine(state is BlocGetManagerDataSuccessState?state.managerData.email!:""),

                      Container(
                          width: double.infinity,
                          child: InkWell(
                            onTap: (){
                              scrollController.animateTo(scrollController.position.minScrollExtent,  duration: Duration(milliseconds: 500), curve: Curves.ease);
                              BlocProvider.of<ProfileManagerCubit>(context).getManagerData(
                                  state is BlocGetManagerDataSuccessState?state.managerData.managerCode!:
                                  user.employeeData!.managerCode!
                              );
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
                                          child: Container(
                                            width: double.infinity,
                                            child: Text(
                                              user.employeeData!.managerCode!,
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
                                Flexible(
                                  flex: 1,
                                  child: Icon(Icons.navigate_next_rounded,
                                    color: Colors.white,size: 40.0,),
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



  String getDirectmanager(ProfileManagerState state){
    if(state is BlocGetManagerDataSuccessState){
      if(state.managerData.managerCode==null){
        return "";
      }else{
        return state.managerData.managerCode!;
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