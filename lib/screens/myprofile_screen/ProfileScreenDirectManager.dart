import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/profile_manager_screen_bloc/profile_manager_cubit.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/dialog_popup_userprofile.dart';
import 'package:hassanallamportalflutter/widgets/drawer/main_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class DirectManagerProfileScreen extends StatefulWidget {

  static const routeName = "/direct-manager-profile-screen";
  const DirectManagerProfileScreen({Key? key}) : super(key: key);

  @override
  State<DirectManagerProfileScreen> createState() => DirectManagerProfileScreenClass();
}

class DirectManagerProfileScreenClass extends State<DirectManagerProfileScreen> {

  final RoundedLoadingButtonController directManagerButton = RoundedLoadingButtonController();

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

    final user = context.select((AppBloc bloc) => bloc.state.userData);

    ///Create a new vCard
    VCard vCard = VCard();


    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
        ),


        resizeToAvoidBottomInset: false,
        body: BlocProvider<ProfileManagerCubit>(
            create: (context) =>
            ProfileManagerCubit()
              ..getManagerData(user.employeeData!.managerCode!),
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
                  if (state is BlocGetManagerDataErrorState) {
                    directManagerButton.error();
                  }
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
                                            state is BlocGetManagerDataSuccessState?state.managerData.name!:"",
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
                                            backgroundImage:
                                            NetworkImage(
                                              "https://portal.hassanallam.com/Apps/images/Profile/${
                                                  state is BlocGetManagerDataSuccessState?state.managerData.userHrCode!:"10204738"
                                                }.jpg"),

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
                                        child: RoundedLoadingButton(
                                          controller: directManagerButton,
                                          onPressed: (){
                                            Timer(Duration(seconds: 1), () {
                                              directManagerButton.reset();
                                              scrollController.animateTo(scrollController.position.minScrollExtent,  duration: Duration(milliseconds: 500), curve: Curves.ease);
                                              BlocProvider.of<ProfileManagerCubit>(context)
                                                  .getManagerData(
                                                  state is BlocGetManagerDataSuccessState?state.managerData.managerCode!:
                                                  user.employeeData!.managerCode!
                                              );
                                            });
                                          },
                                          child: Text(
                                            'Direct Manager: \n${
                                                state is BlocGetManagerDataSuccessState?state.managerData.managerCode!:""
                                              }',
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  39, 105, 171, 1),
                                              fontSize: 16,
                                              fontFamily: 'Nunito',),
                                            textAlign: TextAlign.left,),
                                        )
                                    ),

                                    Container(
                                      width: double.infinity,
                                      height: height * 0.08,
                                      child: Text(


                                        'Mobile Number: \n${
                                            state is BlocGetManagerDataSuccessState?state.managerData.mobile!:""
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
                                        //'Ext: \n' + employeeDataManager.deskPhone!,

                                         state is BlocGetManagerDataSuccessState?state.managerData.deskPhone!:"",
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
}
