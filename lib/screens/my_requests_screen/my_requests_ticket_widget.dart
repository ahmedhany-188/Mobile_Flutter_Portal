
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/request_service_id.dart';
import 'package:hassanallamportalflutter/data/models/my_requests_model/my_requests_model_form.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/business_card_screen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/access_right_screen.dart';
import 'package:hassanallamportalflutter/screens/it_requests_screen/email_and_useraccount_screen.dart';
import 'package:sizer/sizer.dart';

import '../it_requests_screen/equipments_request_screen.dart';

class MyRequestsItemWidget extends StatelessWidget {

  final List<MyRequestsModelData> listFromRequestScreen;
  const MyRequestsItemWidget(this.listFromRequestScreen,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (c,o,d){return ConditionalBuilder(
      condition: listFromRequestScreen.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              _pushForRequestDetail(context, listFromRequestScreen[index]);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey.shade400.withOpacity(0.4),
                // gradient: const LinearGradient(
                //     colors: [
                      // Color(0xFF1a4c78),
                      // Color(0xFF3772a6),
                    // ],
                    // begin: Alignment.bottomLeft,
                    // end: Alignment.topRight,
                    // tileMode: TileMode.clamp),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.3),
                //     spreadRadius: 5,
                //     blurRadius: 3,
                //     offset: const Offset(0, 2), // changes position of shadow
                //   ),
                // ],
              ),
                child: SizedBox(
                  //TODO change size .h
                  height: 20.0.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${listFromRequestScreen[index].serviceName}'.trim(),
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '# ${listFromRequestScreen[index].requestNo}'.trim(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          width: double.infinity,
                          // Todo  .h height
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
                              GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(listFromRequestScreen[index].reqDate ?? "")),
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
      const Center(child: Text('No Data Found')),
    );});
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
            const Icon(Icons.pending_actions_outlined, color: Colors.yellow,)
          ],
          );
        }
    }
  }

  _pushForRequestDetail(BuildContext context,MyRequestsModelData myRequestsModelData){
    switch (myRequestsModelData.serviceID)
    {
      case RequestServiceID.vacationServiceID:
        {
          Navigator.of(context)
              .pushNamed(VacationScreen.routeName,arguments: {VacationScreen.requestNoKey: myRequestsModelData.requestNo.toString(),VacationScreen.requesterHRCode: myRequestsModelData.requestHRCode});
          break;
        }
      case RequestServiceID.permissionServiceID:
        {
          Navigator.of(context)
              .pushNamed(PermissionScreen.routeName,arguments: {PermissionScreen.requestNoKey: myRequestsModelData.requestNo.toString()});
          break;
        }
      case RequestServiceID.businessMissionServiceID:
        {
          Navigator.of(context)
              .pushNamed(BusinessMissionScreen.routeName,arguments: {BusinessMissionScreen.requestNoKey: myRequestsModelData.requestNo.toString()});
          break;
        }
      case RequestServiceID.embassyServiceID:
        {
          Navigator.of(context)
              .pushNamed(EmbassyLetterScreen.routeName,arguments: {EmbassyLetterScreen.requestNoKey: myRequestsModelData.requestNo.toString()});
          break;
        }
      case RequestServiceID.accessRightServiceID:
        {
          Navigator.of(context)
              .pushNamed(AccessRightScreen.routeName,arguments: {AccessRightScreen.requestNoKey: myRequestsModelData.requestNo.toString()
            ,AccessRightScreen.requesterHRCode: myRequestsModelData.requestHRCode.toString()});
          break;
        }
      case RequestServiceID.emailUserAccountServiceID:
        {
          Navigator.of(context)
              .pushNamed(EmailAndUserAccountScreen.routeName,arguments: {EmailAndUserAccountScreen.requestNoKey: myRequestsModelData.requestNo.toString()
              ,EmailAndUserAccountScreen.requesterHRCode: myRequestsModelData.requestHRCode.toString()});
          break;
        }
      case RequestServiceID.businessCardServiceID:
        {
          Navigator.of(context)
              .pushNamed(BusinessCardScreen.routeName,arguments: {BusinessCardScreen.requestNoKey: myRequestsModelData.requestNo.toString()
            , BusinessCardScreen.requesterHRCode: myRequestsModelData.requestHRCode.toString()}   );
          break;
        }
      case RequestServiceID.equipmentServiceID:
        {
          Navigator.of(context)
              .pushNamed(EquipmentsRequestScreen.routeName,arguments: {EquipmentsRequestScreen.requestNoKey: myRequestsModelData.requestNo.toString(),EquipmentsRequestScreen.requesterHrCode: myRequestsModelData.requestHRCode.toString(),'date': myRequestsModelData.reqDate });
          break;
        }

    }
  }
}