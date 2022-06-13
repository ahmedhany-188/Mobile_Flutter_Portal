import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/my_requests_detail_screen_bloc/my_requests_detail_cubit.dart';
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

        body: BlocListener<MyRequestsDetailCubit, MyRequestsDetailState>(

          listener: (contextListener, state) {
            if (state is BlocGetTheVacationDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              VacationModelFormData vacationModelFormData = VacationModelFormData(
                  data[0]["requestNo"],
                  data[0]["serviceId"],
                  data[0]["requestHrCode"],
                  data[0]["responsible"],
                  data[0]["date"],
                  data[0]["status"],
                  data[0]["comments"],
                  data[0]["vacationType"],
                  data[0]["dateFrom"],
                  data[0]["dateTo"],
                  data[0]["noOfDays"]);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VacationScreen(
                            vacationRequestModel: vacationModelFormData,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetThePermissionDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              PermissionFormModelData permissionFormModelData = PermissionFormModelData(
                  data[0]["requestNo"],
                  data[0]["serviceId"],
                  data[0]["requestHrCode"],
                  data[0]["date"],
                  data[0]["status"],
                  data[0]["comments"],
                  data[0]["type"],
                  data[0]["dateFrom"],
                  data[0]["dateTo"],
                  data[0]["dateFromAmpm"],
                  data[0]["dateToAmpm"],
                  data[0]["permissionDate"]);

              int.parse(data[0]["dateFrom"]) - data[0]["dateTo"];


              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PermissionScreen(
                            permissionFormModelData: permissionFormModelData,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetTheBusinessMissionDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              BusinessMissionFormModelData businessMissionFormModelData = BusinessMissionFormModelData(
                  data[0]["requestNo"],
                  data[0]["serviceId"],
                  data[0]["requestHrCode"],
                  data[0]["date"],
                  data[0]["status"],
                  data[0]["comments"],
                  data[0]["missionLocation"],
                  data[0]["dateFrom"],
                  data[0]["dateTo"],
                  data[0]["hourFrom"],
                  data[0]["hourTo"],
                  data[0]["dateFromAmpm"],
                  data[0]["dateToAmpm"]);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BusinessMissionScreen(
                            businessMissionFormModelData: businessMissionFormModelData,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetTheEmbassyLetterDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              EmbassyLetterFormModel embassyLetterFormModel = EmbassyLetterFormModel(
                  data[0]["date"],
                  data[0]["purpose"],
                  data[0]["embassyId"],
                  data[0]["dateFrom"],
                  data[0]["dateTo"],
                  data[0]["passportNo"],
                  data[0]["addSalary"],
                  data[0]["comments"]);


              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmbassyLetterScreen(
                            embassyLetterFormModel: embassyLetterFormModel,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetTheEmailAccountDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              EmailUserFormModel emailUserFormModel = EmailUserFormModel(
                  data[0]["date"], data[0]["reqType"],
                  data[0]["ownerMobile"], data[0]["emailAccount"]);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmailAndUserAccountScreen(
                            emailUserAccount: emailUserFormModel,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetTheBusinessCardDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              BusinessCardFormModel businessCardFormModel = BusinessCardFormModel(
                  data[0]["date"], data[0]["cardName"],
                  data[0]["employeeMobil"], data[0]["extNo"],
                  data[0]["faxNo"], data[0]["comments"]);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BusinessCardScreen(
                            businessCardFormModel: businessCardFormModel,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetTheAccessRightDataSuccesState) {
              List<dynamic>data = jsonDecode(state.getData);
              AccessRightModel accessRightModel = AccessRightModel(
                  data[0]["reqType"],
                  data[0]["usbException"],
                  data[0]["vpnAccount"],
                  data[0]["ipPhone"],
                  data[0]["localAdmin"],
                  data[0]["isPermanent"],
                  data[0]["date"],
                  data[0]["startDate"],
                  data[0]["endDate"],
                  data[0]["filePdf"],
                  data[0]["comments"],
                  []);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AccessUserAccountScreen(
                            accessRightModel: accessRightModel,
                            objectValidation: true),
                  ));
            }

            else if (state is BlocGetTheDataErrorState) {}

            else if (state is BlocGetTheDataLoadingState) {}
          },
          child: ConditionalBuilder(
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
                    List<String> rDate = listFromRequestScreen[index]["rDate"]
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
                                context.read<MyRequestsDetailCubit>()
                                    .getVacationRequestData(
                                    hrCode, reqNumber);
                                break;
                              }

                            case "Permission":
                              {
                                context.read<MyRequestsDetailCubit>()
                                    .getPermissionRequestData(
                                    hrCode, reqNumber);
                                break;
                              }
                            case "Business Mission":
                              {
                                context.read<MyRequestsDetailCubit>()
                                    .getBusinessMissionData(
                                    hrCode, reqNumber);
                                break;
                              }
                            case "Embassy Letter":
                              {
                                context.read<MyRequestsDetailCubit>()
                                    .getEmbassyLetterData(
                                    hrCode, reqNumber);

                                break;
                              }
                            case "Email Account":
                              {
                                context.read<MyRequestsDetailCubit>()
                                    .getEmailAccountData(
                                    hrCode, reqNumber);

                                break;
                              }
                            case "Business Card Request":
                              {
                                context.read<MyRequestsDetailCubit>()
                                    .getBusinessCardData(
                                    hrCode, reqNumber);

                                break;
                              }
                            case "Access Right IT" :
                              {
                                context.read<MyRequestsDetailCubit>()
                                    .getAccessRightITData(
                                    hrCode, reqNumber);
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
          ),

        )
    );
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