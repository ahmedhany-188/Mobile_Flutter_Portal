import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/profile_manager_screen_bloc/profile_manager_cubit.dart';
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


    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          centerTitle: true,
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/S_Background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),

                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 40),
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
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 80,
                                              ),

                                              Text(
                                            state is BlocGetManagerDataSuccessState ?state.managerData.name!:"",

                                                  style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                  39, 105, 171, 1),
                                                  fontFamily: 'Nunito',
                                                  fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  ),
                                              Text(
                                                state is BlocGetManagerDataSuccessState?state.managerData.titleName!:"",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      39, 105, 171, 1),
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
                                                          color: Colors
                                                              .grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Text(
                                                        state is BlocGetManagerDataSuccessState?state.managerData.userHrCode!:"",
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 25,
                                                      vertical: 8,
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      width: 3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Grade',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey[700],
                                                          fontFamily: 'Nunito',
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        state is BlocGetManagerDataSuccessState?state.managerData.gradeName.toString():"",
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

                                                data: state is BlocGetManagerDataSuccessState?vCard.getFormattedString():"",
                                                version: QrVersions.auto,
                                                size: width * 0.40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
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
                                        'Department: \n${
                                            state is BlocGetManagerDataSuccessState?state.managerData.projectName!:""
                                          }',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(
                                              39, 105, 171, 1),

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
                                         'Job Title: \n${
                                             state is BlocGetManagerDataSuccessState?state.managerData.titleName!:""
                                          }'
                                        , style: const TextStyle(
                                        color: Color.fromRGBO(
                                            39, 105, 171, 1),
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
                                         'Email: \n${
                                             state is BlocGetManagerDataSuccessState?state.managerData.email!:""
                                          }',
                                         style: const TextStyle(
                                        color: Color.fromRGBO(
                                            39, 105, 171, 1),
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
                                        child: InkWell(
                                          onTap: (){
                                              scrollController.animateTo(scrollController.position.minScrollExtent,  duration: Duration(milliseconds: 500), curve: Curves.ease);
                                              BlocProvider.of<ProfileManagerCubit>(context).getManagerData(
                                                  state is BlocGetManagerDataSuccessState?state.managerData.managerCode!:
                                                  user.employeeData!.managerCode!
                                              );
                                          },
                                          child:
                                          Text(
                                            'Direct Manager: ${
                                                // state is BlocGetManagerDataSuccessState?
                                                // state.managerData.managerCode!:""
                                                getDirectmanager(state)
                                              }',
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  39, 105, 171, 1),
                                              fontSize: 16,
                                              decoration: TextDecoration.underline,
                                              fontFamily: 'Nunito',),
                                            textAlign: TextAlign.left,),
                                        )
                                    ),

                                    Container(
                                      width: double.infinity,
                                      height: height * 0.08,
                                      child: Text(
                                        'Mobile Number: \n${
                                            // state is BlocGetManagerDataSuccessState?state.managerData.mobile:""
                                            getMobile(state)
                                          }',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(
                                              39, 105, 171, 1),
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
                                        'Ext: \n${
                                       // state is BlocGetManagerDataSuccessState?state.managerData.deskPhone!:"",
                                        getExt(state)
                                          }',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(
                                              39, 105, 171, 1),
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
                  );
                }
            )
        )
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

}