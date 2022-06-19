import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/request_service_id.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/screens/about_value_screen/value_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';

class MyRequestsItemWidget extends StatelessWidget {

  final List<MyRequestsModelData> listFromRequestScreen;
  const MyRequestsItemWidget(this.listFromRequestScreen,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
          condition: listFromRequestScreen.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(

              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1a4c78),
                        Color(0xFF3772a6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.clamp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 3,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    _pushForRequestDetail(context, listFromRequestScreen[index]);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 22.0.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Center(
                                  child: Text(
                                    '${listFromRequestScreen[index].serviceName}'.trim(),
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 0.2.h,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    // Text(
                                    //   '${listFromRequestScreen[index].statusName}'
                                    //       .trim(),
                                    //   style: const TextStyle(
                                    //     fontSize: 14.0,
                                    //     color: Colors.white,
                                    //   ),
                                    //   maxLines: 2,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   textAlign: TextAlign.center,
                                    // ),
                                    MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                    Text(
                                      '${listFromRequestScreen[index].rDate}',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              child: Container(
                width: double.infinity,
                height: 0.2.h,
                color: Colors.grey[300],
              ),
            ),
            itemCount: listFromRequestScreen.length,
          ),
              // (context) =>
              // GridView.builder(
              //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
              //       .onDrag,
              //   shrinkWrap: true,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 1,
              //     // childAspectRatio: (1 / .4),
              //     mainAxisExtent: 90, // here set custom Height You Want
              //     // width between items
              //     crossAxisSpacing: 30,
              //     // height between items
              //     mainAxisSpacing: 30,
              //   ),
              //   itemCount: listFromRequestScreen.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     MyRequestsModelData myRequestsModelData = listFromRequestScreen[index];
              //     return SizedBox(
              //       width: double.infinity,
              //       child: InkWell(
              //
              //         onTap: () {
              //           _pushForRequestDetail(context,myRequestsModelData);
              //         },
              //         child: Container(
              //           height: 50,
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             color: Colors.white,
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(myRequestsModelData.serviceName.toString(),
              //                   style: const TextStyle(
              //                       color: Colors.black, fontSize: 18)),
              //               MyRequestStatus(myRequestsModelData.statusName.toString(), context),
              //               Text(myRequestsModelData.rDate.toString(),
              //                   style: const TextStyle(
              //                       color: Colors.black, fontSize: 16)),
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
          fallback: (context) =>
          const Center(child: LinearProgressIndicator()),
        );
  }

  // ignore: non_constant_identifier_names
  Widget MyRequestStatus(String statusName, BuildContext context) {
    switch (statusName) {
      case "Approved" :
        {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(statusName, style: const TextStyle(fontSize: 16,color: Colors.white),),
            const Icon(Icons.verified, color: Colors.green,),
          ],
          );
        }
      case "Rejected" :
        {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(statusName, style: const TextStyle(fontSize: 16,color: Colors.white),),
            const Icon(Icons.cancel, color: Colors.red,)
          ],
          );
        }
      default:
        {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(statusName, style: const TextStyle(fontSize: 16,color: Colors.white),),
            const Icon(Icons.camera, color: Colors.yellow,)
          ],
          );
        }
    }
  }

  _pushForRequestDetail(BuildContext context,MyRequestsModelData myRequestsModelData){
    switch (myRequestsModelData.serviceID)
    {
      case RequestServiceID.VacationServiceID:
        {
          Navigator.of(context)
              .pushNamed(VacationScreen.routeName,arguments: {VacationScreen.requestNoKey: myRequestsModelData.requestNo.toString()});
          break;
        }
      case RequestServiceID.PermissionServiceID:
        {
          Navigator.of(context)
              .pushNamed(PermissionScreen.routeName,arguments: {PermissionScreen.requestNoKey: myRequestsModelData.requestNo.toString()});

          break;
        }
      case RequestServiceID.BusinessMissionServiceID:
        {
          Navigator.of(context)
              .pushNamed(BusinessMissionScreen.routeName,arguments: {BusinessMissionScreen.requestNoKey: myRequestsModelData.requestNo.toString()});
          break;
        }
      case RequestServiceID.EmbassyServiceID:
        {
          Navigator.of(context)
              .pushNamed(EmbassyLetterScreen.routeName,arguments: {EmbassyLetterScreen.requestNoKey: myRequestsModelData.requestNo.toString()});
          break;
        }
      // case "Embassy Letter":
      //   {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) =>
      //               EmbassyLetterScreen(
      //                 requestNo: myRequestsModelData.requestNo,),
      //         ));
      //     break;
      //   }
      // case "Email Account":
      //   {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) =>
      //               EmailAndUserAccountScreen(
      //                 requestNo: myRequestsModelData.requestNo,),
      //         ));
      //
      //     break;
      //   }
      // case "Business Card Request":
      //   {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) =>
      //               BusinessCardScreen(
      //                 requestNo: myRequestsModelData.requestNo,),
      //         ));
      //     break;
      //   }
      // case "Access Right IT" :
      //   {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) =>
      //               AccessUserAccountScreen(
      //                 requestNo: myRequestsModelData.requestNo,),
      //         ));
      //     break;
      //   }
    }
  }
}