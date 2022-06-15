import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_detail_screen_bloc/my_requests_detail_cubit.dart';
import 'package:hassanallamportalflutter/data/data_providers/my_requests_data_provider/my_requests_detail_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_business_mission_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_permission_form_model.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_vacation_form_model.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';

class MyReqyestsTicketWidget extends StatelessWidget {

  final List<dynamic> listFromRequestScreen;
  final String hrCode;

  const MyReqyestsTicketWidget(this.listFromRequestScreen, this.hrCode,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
        // BlocListener<MyRequestsDetailCubit, MyRequestsDetailState>(
        //
        //   listener: (contextListener, state) {
        //     // if (state is BlocGetTheVacationDataSuccesState) {
        //     // }
        //     // else if (state is BlocGetThePermissionDataSuccesState) {
        //     //   List<dynamic>data = jsonDecode(state.getData);
        //     //   // PermissionFormModelData permissionFormModelData = PermissionFormModelData(
        //     // }
        //     //
        //     // else if (state is BlocGetTheBusinessMissionDataSuccesState) {
        //     //   List<dynamic>data = jsonDecode(state.getData);
        //     //   // BusinessMissionFormModelData businessMissionFormModelData = BusinessMissionFormModelData(
        //     // }
        //     //
        //     // else if (state is BlocGetTheEmbassyLetterDataSuccesState) {
        //     //   List<dynamic>data = jsonDecode(state.getData);
        //     //   EmbassyLetterFormModel embassyLetterFormModel = EmbassyLetterFormModel(

        //     // }
        //     //
        //     // else if (state is BlocGetTheEmailAccountDataSuccesState) {
        //     //   List<dynamic>data = jsonDecode(state.getData);
        //     // }
        //     //
        //     // else if (state is BlocGetTheBusinessCardDataSuccesState) {
        //     //   List<dynamic>data = jsonDecode(state.getData);

        //     // }
        //     //
        //     // else if (state is BlocGetTheAccessRightDataSuccesState) {
        //     //   List<dynamic>data = jsonDecode(state.getData);
        //     //
        //     // }
        //     //
        //     // else if (state is BlocGetTheDataErrorState) {}
        //     //
        //     // else if (state is BlocGetTheDataLoadingState) {}
        //   },
        ConditionalBuilder(
          condition: listFromRequestScreen.isNotEmpty,

          builder: (context) =>


              GridView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // childAspectRatio: (1 / .4),
                  mainAxisExtent: 90, // here set custom Height You Want
                  // width between items
                  crossAxisSpacing: 30,
                  // height between items
                  mainAxisSpacing: 30,
                ),

                itemCount: listFromRequestScreen.length,
                itemBuilder: (BuildContext context, int index) {
                  List<String> rDate = listFromRequestScreen[index]["req_Date"]
                      .toString().split('T');

                  int reqNumber = listFromRequestScreen[index]["request_No"];
                  String statusName = listFromRequestScreen[index]["status_Name"];
                  String serviceName = listFromRequestScreen[index]["service_Name"];

                  return SizedBox(

                    width: double.infinity,
                    child: InkWell(

                      onTap: () {
                        switch (serviceName) {
                          case "Vacation Request":
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getVacationRequestData(
                              //     hrCode, reqNumber);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VacationScreen(requestNo: reqNumber,),
                                  ));
                              break;
                            }

                          case "Permission":
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getPermissionRequestData(
                              //     hrCode, reqNumber);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PermissionScreen(requestNo: reqNumber,),
                                  ));
                              break;
                            }
                          case "Business Mission":
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getBusinessMissionData(
                              //     hrCode, reqNumber);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BusinessMissionScreen(
                                          requestNo: reqNumber,),
                                  ));
                              break;
                            }
                          case "Embassy Letter":
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getEmbassyLetterData(
                              //     hrCode, reqNumber);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EmbassyLetterScreen(
                                          requestNo: reqNumber,),
                                  ));
                              break;
                            }
                          case "Email Account":
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getEmailAccountData(
                              //     hrCode, reqNumber);


                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EmailAndUserAccountScreen(
                                          requestNo: reqNumber,),
                                  ));

                              break;
                            }
                          case "Business Card Request":
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getBusinessCardData(
                              //     hrCode, reqNumber);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BusinessCardScreen(
                                          requestNo: reqNumber,),
                                  ));
                              break;
                            }
                          case "Access Right IT" :
                            {
                              // context.read<MyRequestsDetailCubit>()
                              //     .getAccessRightITData(
                              //     hrCode, reqNumber);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AccessUserAccountScreen(
                                          requestNo: reqNumber,),
                                  ));
                              break;
                            }
                        }
                      },
                      child: Container(

                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(serviceName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            MyRequestStatus(statusName, context),
                            Text(rDate[0],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ],
                        ),


                      ),
                    ),
                  );
                },
              ),
          fallback: (context) =>
          const Center(child: LinearProgressIndicator()),
        ));
  }

  // ignore: non_constant_identifier_names
  dynamic MyRequestStatus(String statusName, BuildContext context) {
    switch (statusName) {
      case "Approved" :
        {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(statusName, style: const TextStyle(fontSize: 16),),
            const Icon(Icons.verified, color: Colors.green,),
          ],
          );
        }
      case "Rejected" :
        {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(statusName, style: const TextStyle(fontSize: 16),),
            const Icon(Icons.cancel, color: Colors.red,)
          ],
          );
        }
      default:
        {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(statusName, style: const TextStyle(fontSize: 16),),
            const Icon(Icons.camera, color: Colors.yellow,)
          ],
          );
        }
    }
  }
}