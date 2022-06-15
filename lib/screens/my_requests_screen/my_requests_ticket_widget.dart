import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';

class MyReqyestsTicketWidget extends StatelessWidget {

  final List<MyRequestsModelData> listFromRequestScreen;
  final String hrCode;

  const MyReqyestsTicketWidget(this.listFromRequestScreen, this.hrCode,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ConditionalBuilder(
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
                  String? rDate = GlobalConstants.dateFormatViewed.format(listFromRequestScreen[index].reqDate as DateTime);
                  // .toString().split('T');
                  int? reqNumber = listFromRequestScreen[index].requestNo;
                  String? statusName = listFromRequestScreen[index].statusName;
                  String? serviceName = listFromRequestScreen[index]
                      .serviceName;

                  return SizedBox(

                    width: double.infinity,
                    child: InkWell(

                      onTap: () {
                        switch (serviceName) {
                          case "Vacation Request":
                            {
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
                            Text(serviceName.toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            MyRequestStatus(statusName.toString(), context),
                            Text(rDate.toString(),
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