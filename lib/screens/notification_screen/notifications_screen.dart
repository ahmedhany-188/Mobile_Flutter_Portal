import 'package:formz/formz.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import './notification_widget.dart';
import '../../widgets/background/custom_background.dart';
import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = 'notifications-screen';

  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  TextEditingController textController = TextEditingController();
  FocusNode textFoucus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: CustomBackground(
        child: CustomTheme(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text("Your Notification")),
            body: RefreshIndicator(
              onRefresh: () async {
                await UserNotificationApiCubit.get(context).getNotifications();
                // await Future.delayed(const Duration(milliseconds: 1000));
                return Future(() => null);
              },
              child: BlocProvider<UserNotificationApiCubit>.value(
                value: UserNotificationApiCubit.get(context)..getNotificationsWithoutLoading(),
                child: BlocConsumer<UserNotificationApiCubit,
                    UserNotificationApiState>(
                  listener: (context, state) {
                    print(state.status);
                    if (state.status.isSubmissionInProgress) {
                      EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                        dismissOnTap: false,
                      );
                    }
                    if (state.status.isSubmissionSuccess) {
                      EasyLoading.showSuccess(state.successMessage ?? "").then(
                              (value) =>
                              UserNotificationApiCubit.get(context)
                                  .getNotifications());
                    }
                    if (state.status.isSubmissionFailure) {
                      EasyLoading.showError(
                          state.errorMessage ?? 'Request Failed');
                    }
                  },
                  builder: (context, state) {
                    if (kDebugMode) {
                      print(state.userNotificationEnumStates);
                    }
                    return Sizer(builder: (ctx, ori, dt) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              focusNode: textFoucus,
                              // key: uniqueKey,
                              controller: textController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              onChanged: (text) {
                                UserNotificationApiCubit.get(context)
                                    .writenTextSearch(text);
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                                hintText:
                                "Search by 'request number, request name'",
                                suffixIcon: (textController.text.isEmpty)
                                    ? null
                                    : IconButton(
                                  onPressed: () {
                                    textController.clear();
                                    textFoucus.unfocus();
                                    UserNotificationApiCubit.get(context)
                                        .onClearData();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: (state.isFiltered &&
                                textController.text.isNotEmpty)
                                ? NotificationWidget(
                                listFromnotificationScreen:
                                state.userNotificationResultList)
                                : NotificationWidget(
                                listFromnotificationScreen:
                                state.userNotificationList),
                          ),
                        ],
                      );
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
//
// ConditionalBuilder buildConditionalBuilder(UserNotificationApiState state, MainUserData userMainData) {
//   return ConditionalBuilder(
//                         condition: state.userNotificationEnumStates ==
//                                 UserNotificationEnumStates.success ||
//                             (state.userNotificationEnumStates ==
//                                     UserNotificationEnumStates
//                                         .noConnection &&
//                                 state.userNotificationList.isNotEmpty) ||
//                             (state.userNotificationEnumStates ==
//                                     UserNotificationEnumStates.failed &&
//                                 state.userNotificationList.isNotEmpty),
//                         builder: (context) {
//                           return Padding(
//                             padding: EdgeInsets.all(5.0.sp),
//                             child: ListView.separated(
//                               physics: const BouncingScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: state.userNotificationList.length,
//                               itemBuilder: (ctx, index) {
//                                 UserNotificationApi notification =
//                                     // (state.isFiltered)?state.userNotificationResultList[index]:
//                                     state.userNotificationList[index];
//                                 var imageProfile =
//                                     notification.imgProfile ?? "";
//                                 return Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: InkWell(
//                                     onTap: () {
//                                       _pushForRequestDetail(context, notification);
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.only(
//                                           left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15.0),
//                                         color: Colors.grey.shade400.withOpacity(0.4),
//                                       ),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Expanded(
//                                             flex: 2,
//                                             child: SizedBox(
//                                               height: MediaQuery.of(context).size.height * 0.20,
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 children: [
//                                                   Flexible(
//                                                     fit: FlexFit.loose,
//                                                     child: Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Flexible(
//                                                           fit: FlexFit.loose,
//                                                           flex: 1,
//                                                           child: imageProfile.isNotEmpty
//                                                               ? CachedNetworkImage(
//                                                             imageUrl:
//                                                             getUserProfilePicture(imageProfile),
//                                                             imageBuilder: (context, imageProvider) =>
//                                                                 Container(
//                                                                   width: 40.sp,
//                                                                   height: 40.sp,
//                                                                   decoration: BoxDecoration(
//                                                                     shape: BoxShape.circle,
//                                                                     image: DecorationImage(
//                                                                         image: imageProvider,
//                                                                         fit: BoxFit.cover),
//                                                                   ),
//                                                                 ),
//                                                             placeholder: (context, url) => Assets
//                                                                 .images.logo
//                                                                 .image(height: 60.sp),
//                                                             errorWidget: (context, url, error) =>
//                                                                 Assets.images.logo
//                                                                     .image(height: 60.sp),
//                                                           )
//                                                               : Assets.images.logo.image(height: 60.sp),
//                                                         ),
//                                                         Center(
//                                                           child: Column(
//                                                             mainAxisAlignment: MainAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 '${notification.reqName?.toTitleCase()}'
//                                                                     .trim(),
//                                                                 style: const TextStyle(
//                                                                   fontSize: 14.0,
//                                                                   fontWeight: FontWeight.w600,
//                                                                   color: Colors.white,
//                                                                   fontFamily: FontFamily.robotoFlex,
//                                                                 ),
//                                                                 maxLines: 1,
//                                                                 // overflow: TextOverflow.ellipsis,
//                                                               ),
//                                                               Text(
//                                                                 '${notification.projectName}'.trim(),
//
//                                                                 style: const TextStyle(
//                                                                   fontSize: 12.0,
//                                                                   fontWeight: FontWeight.w600,
//                                                                   color: Colors.white,
//                                                                   fontFamily: FontFamily.robotoFlex,
//                                                                 ),
//                                                                 maxLines: 1,
//                                                                 // overflow: TextOverflow.ellipsis,
//                                                               ),
//                                                               Text(
//                                                                 '${notification.requestHRCode}'.trim(),
//                                                                 style: const TextStyle(
//                                                                   fontSize: 12.0,
//                                                                   fontWeight: FontWeight.w600,
//                                                                   color: Colors.white,
//                                                                   fontFamily: FontFamily.robotoFlex,
//                                                                 ),
//                                                                 maxLines: 1,
//                                                                 // overflow: TextOverflow.ellipsis,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(top: 5, bottom: 5),
//                                                     child: Container(
//                                                       width: double.infinity,
//                                                       height: 0.2.h,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     clipBehavior: Clip.none,
//                                                     alignment: Alignment.center,
//                                                     child: Column(
//                                                       children: [
//                                                         Text(
//                                                           ' ${notification.status} ${notification.serviceName} #${notification.requestNo}',
//                                                           style: const TextStyle(
//                                                             fontSize: 13.0,
//                                                             color: Colors.white,
//                                                             fontFamily: FontFamily.robotoFlex,
//                                                           ),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow.ellipsis,
//                                                           textAlign: TextAlign.center,
//                                                         ),
//                                                         // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
//                                                         Text(
//                                                           'comment: ${notification.reqComment}',
//                                                           style: const TextStyle(
//                                                             fontSize: 13.0,
//                                                             color: Colors.white,
//                                                             fontFamily: FontFamily.robotoFlex,
//                                                           ),
//                                                           maxLines: 1,
//                                                           overflow: TextOverflow.ellipsis,
//                                                           textAlign: TextAlign.center,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   if (notification.requestHRCode !=
//                                                       userMainData.employeeData?.userHrCode)
//                                                     Padding(
//                                                       padding: const EdgeInsets.all(5.0),
//                                                       child: Container(
//                                                         clipBehavior: Clip.none,
//                                                         alignment: Alignment.center,
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                               MainAxisAlignment.spaceEvenly,
//                                                               children: [
//                                                                 Expanded(
//                                                                   child: OutlinedButton(
//                                                                     onPressed: () {
//                                                                       BlocProvider.of<
//                                                                           UserNotificationApiCubit>(
//                                                                           context)
//                                                                           .submitRequestAction(
//                                                                           ActionValueStatus.accept,
//                                                                           notification);
//                                                                     },
//                                                                     style: OutlinedButton.styleFrom(
//                                                                         backgroundColor:
//                                                                         ConstantsColors.buttonColors),
//                                                                     child: const Text('Accept',
//                                                                         style:
//                                                                         TextStyle(color: Colors.white)),
//                                                                     // color: Colors.white,
//                                                                   ),
//                                                                 ),
//                                                                 const SizedBox(
//                                                                   width: 12,
//                                                                 ),
//                                                                 // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
//                                                                 Expanded(
//                                                                   child: OutlinedButton(
//                                                                     onPressed: () {
//                                                                       BlocProvider.of<
//                                                                           UserNotificationApiCubit>(
//                                                                           context)
//                                                                           .submitRequestAction(
//                                                                           ActionValueStatus.reject,
//                                                                           notification);
//                                                                     },
//                                                                     style: OutlinedButton.styleFrom(
//                                                                         backgroundColor: Colors.white),
//                                                                     child: const Text(
//                                                                       'Reject',
//                                                                       style: TextStyle(
//                                                                           color:
//                                                                           ConstantsColors.buttonColors),
//                                                                     ),
//
//                                                                     // color: Colors.white,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             Text(
//                                                               GlobalConstants.dateFormatViewedDaysAndHours
//                                                                   .format(GlobalConstants.dateFormatServer
//                                                                   .parse(notification.reqDate ?? "")),
//                                                               style: const TextStyle(
//                                                                 fontSize: 10.0,
//                                                                 color: Colors.white,
//                                                                 fontFamily: FontFamily.robotoFlex,
//                                                               ),
//                                                               maxLines: 1,
//                                                               overflow: TextOverflow.ellipsis,
//                                                               textAlign: TextAlign.center,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               separatorBuilder: (context, index) => Padding(
//                                 padding: const EdgeInsetsDirectional.only(
//                                     start: 20.0, end: 20.0),
//                                 child: Container(
//                                   width: double.infinity,
//                                   height: 0.5.sp,
//                                   color: Colors.grey[300],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         fallback: (_) => Shimmer.fromColors(
//                           baseColor: Colors.white,
//                           highlightColor: Colors.grey,
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.all(5.0.sp),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10.0),
//                                       height: 140.sp,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         color: Colors.grey.shade400
//                                             .withOpacity(0.4),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsetsDirectional.only(
//                                             start: 20.0, end: 20.0),
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: 0.5.sp,
//                                       color: Colors.grey[300],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10.0),
//                                       height: 140.sp,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         color:
//                                             Colors.white.withOpacity(0.4),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsetsDirectional.only(
//                                             start: 20.0, end: 20.0),
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: 0.5.sp,
//                                       color: Colors.grey[300],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10.0),
//                                       height: 140.sp,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         color:
//                                             Colors.white.withOpacity(0.4),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsetsDirectional.only(
//                                             start: 20.0, end: 20.0),
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: 0.5.sp,
//                                       color: Colors.grey[300],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10.0),
//                                       height: 140.sp,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         color:
//                                             Colors.white.withOpacity(0.4),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsetsDirectional.only(
//                                             start: 20.0, end: 20.0),
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: 0.5.sp,
//                                       color: Colors.grey[300],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
// }
// _pushForRequestDetail(
//     BuildContext context, UserNotificationApi notification) {
//   switch (notification.serviceID) {
//     case RequestServiceID.vacationServiceID:
//       {
//         Navigator.of(context).pushNamed(VacationScreen.routeName, arguments: {
//           VacationScreen.requestNoKey: notification.requestNo.toString(),
//           VacationScreen.requesterHRCode: notification.requestHRCode
//         });
//         break;
//       }
//     case RequestServiceID.permissionServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(PermissionScreen.routeName, arguments: {
//           PermissionScreen.requestNoKey: notification.requestNo.toString(),
//           PermissionScreen.requesterHRCode: notification.requestHRCode
//         });
//         break;
//       }
//     case RequestServiceID.businessMissionServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(BusinessMissionScreen.routeName, arguments: {
//           BusinessMissionScreen.requestNoKey:
//               notification.requestNo.toString(),
//           BusinessMissionScreen.requesterHRCode: notification.requestHRCode
//         });
//         break;
//       }
//     case RequestServiceID.embassyServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(EmbassyLetterScreen.routeName, arguments: {
//           EmbassyLetterScreen.requestNoKey: notification.requestNo.toString(),
//           EmbassyLetterScreen.requesterHRCode: notification.requestHRCode
//         });
//         break;
//       }
//     case RequestServiceID.accessRightServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(AccessRightScreen.routeName, arguments: {
//           AccessRightScreen.requestNoKey: notification.requestNo.toString(),
//           AccessRightScreen.requesterHRCode:
//               notification.requestHRCode.toString()
//         });
//         break;
//       }
//     case RequestServiceID.emailUserAccountServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(EmailAndUserAccountScreen.routeName, arguments: {
//           EmailAndUserAccountScreen.requestNoKey:
//               notification.requestNo.toString(),
//           EmailAndUserAccountScreen.requesterHRCode:
//               notification.requestHRCode.toString()
//         });
//         break;
//       }
//     case RequestServiceID.businessCardServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(BusinessCardScreen.routeName, arguments: {
//           BusinessCardScreen.requestNoKey: notification.requestNo.toString(),
//           BusinessCardScreen.requesterHRCode:
//               notification.requestHRCode.toString()
//         });
//         break;
//       }
//     case RequestServiceID.equipmentServiceID:
//       {
//         Navigator.of(context)
//             .pushNamed(EquipmentsRequestScreen.routeName, arguments: {
//           EquipmentsRequestScreen.requestNoKey:
//               notification.requestNo.toString(),
//           EquipmentsRequestScreen.requesterHrCode:
//               notification.requestHRCode.toString(),
//           "date": notification.reqDate
//         });
//         break;
//       }
//   }
// }
}
