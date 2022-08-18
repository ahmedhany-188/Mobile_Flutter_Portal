
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:hassanallamportalflutter/bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/request_service_id.dart';
import 'package:hassanallamportalflutter/data/models/user_notification_api/user_notification_api.dart';
import 'package:hassanallamportalflutter/gen/fonts.gen.dart';
import 'package:hassanallamportalflutter/screens/admin_request_screen/embassy_letter_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/permission_request_screen/permission_screen.dart';
import 'package:hassanallamportalflutter/screens/hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../data/helpers/convert_from_html.dart';
import '../../data/models/response_news.dart';
import '../../gen/assets.gen.dart';
import '../admin_request_screen/business_card_screen.dart';
import '../it_requests_screen/access_right_screen.dart';
import '../it_requests_screen/email_and_useraccount_screen.dart';
import '../it_requests_screen/equipments_request.dart';


class NotificationsScreen extends StatefulWidget {
  static const routeName = 'notifications-screen';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {


  @override
  Widget build(BuildContext context) {
    final userMainData = context.select((AppBloc bloc) =>
    bloc.state.userData);
    return CustomBackground(
      child: Scaffold(

        // drawer: MainDrawer(),
        appBar: AppBar(title: const Text("Your Notification"),
          backgroundColor: Colors.transparent,
          elevation: 0,),

        /// basicAppBar(context, 'News'),
        backgroundColor: Colors.transparent,

        body: RefreshIndicator(
          onRefresh: () async {
            await UserNotificationApiCubit.get(context).getNotifications();
            // await Future.delayed(const Duration(milliseconds: 1000));
            return Future(() => null);
          },
          child: BlocBuilder<UserNotificationApiCubit,
              UserNotificationApiState>(
            builder: (context, state) {
              if (kDebugMode) {
                print(state.userNotificationEnumStates);
              }
              return Sizer(builder: (ctx, ori, dt) {
                return ConditionalBuilder(
                  condition: state.userNotificationEnumStates ==
                      UserNotificationEnumStates.success ||
                      (state.userNotificationEnumStates ==
                          UserNotificationEnumStates.noConnection &&
                          state.userNotificationList.isNotEmpty),
                  builder: (context) {
                    // List<Data> newsList = newsAllData;
                    return Padding(
                      padding: EdgeInsets.all(5.0.sp),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.userNotificationList.length,
                        itemBuilder: (ctx, index) {
                          UserNotificationApi notification = state
                              .userNotificationList[index];

                          var imageProfile = notification.imgProfile ?? "";

                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              onTap: () {
                                //TODO add notification to click listener
                                _pushForRequestDetail(context, notification);
                                // _pushForRequestDetail(context, listFromRequestScreen[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 10.0,
                                    right: 10.0,
                                    top: 10.0,
                                    bottom: 0.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.grey.shade400.withOpacity(
                                      0.4),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 22.0.h,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    flex: 1,
                                                    child:
                                                    imageProfile.isNotEmpty
                                                        ? CachedNetworkImage(
                                                      imageUrl: 'https://portal.hassanallam.com/Apps/images/Profile/$imageProfile',
                                                      imageBuilder: (context,
                                                          imageProvider) =>
                                                          Container(
                                                            width: 60.sp,
                                                            height: 60.sp,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image: imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                      placeholder: (context,
                                                          url) =>
                                                          Assets.images.logo
                                                              .image(
                                                              height: 60.sp),
                                                      errorWidget: (context,
                                                          url, error) =>
                                                          Assets.images.logo
                                                              .image(
                                                              height: 60.sp),
                                                    )
                                                        : Assets.images.logo
                                                        .image(height: 60.sp),),
                                                  Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          '${notification
                                                              .reqName
                                                              ?.toTitleCase()}'
                                                              .trim(),
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: Colors.white,
                                                            fontFamily: FontFamily
                                                                .robotoFlex,
                                                          ),
                                                          maxLines: 1,
                                                          // overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text('${notification
                                                            .projectName}'
                                                            .trim(),

                                                          style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: Colors.white,
                                                            fontFamily: FontFamily
                                                                .robotoFlex,
                                                          ),
                                                          maxLines: 1,
                                                          // overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          '${notification
                                                              .requestHRCode}'
                                                              .trim(),
                                                          style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: Colors.white,
                                                            fontFamily: FontFamily
                                                                .robotoFlex,
                                                          ),
                                                          maxLines: 1,
                                                          // overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
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
                                                  Text(
                                                    ' ${notification
                                                        .status} ${notification
                                                        .serviceName} #${notification
                                                        .requestNo}',
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.white,
                                                      fontFamily: FontFamily
                                                          .robotoFlex,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign
                                                        .center,
                                                  ),
                                                  // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                                  Text(
                                                    'comment: ${notification
                                                        .reqComment}',
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.white,
                                                      fontFamily: FontFamily
                                                          .robotoFlex,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign
                                                        .center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if(notification.requestHRCode !=
                                                userMainData.employeeData
                                                    ?.userHrCode)Padding(
                                              padding: const EdgeInsets.all(
                                                  5.0),
                                              child: Container(
                                                clipBehavior: Clip.none,
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Expanded(
                                                          child: OutlinedButton(
                                                            onPressed: () {},
                                                            style: OutlinedButton
                                                                .styleFrom(
                                                                backgroundColor: ConstantsColors
                                                                    .buttonColors
                                                            ),
                                                            child: const Text(
                                                                'Accept',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            // color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 12,),
                                                        // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                                        Expanded(
                                                          child: OutlinedButton(
                                                            onPressed: () {},
                                                            style: OutlinedButton
                                                                .styleFrom(
                                                                backgroundColor: Colors
                                                                    .white),
                                                            child: const Text(
                                                              'Reject',
                                                              style: TextStyle(
                                                                  color: ConstantsColors
                                                                      .buttonColors),),

                                                            // color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      GlobalConstants
                                                          .dateFormatViewedDaysAndHours
                                                          .format(
                                                          GlobalConstants
                                                              .dateFormatServer
                                                              .parse(
                                                              notification
                                                                  .reqDate ??
                                                                  "")),
                                                      style: const TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.white,
                                                        fontFamily: FontFamily
                                                            .robotoFlex,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ],
                                                ),
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
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 20.0, end: 20.0),
                              child: Container(
                                width: double.infinity,
                                height: 0.5.sp,
                                color: Colors.grey[300],
                              ),
                            ),
                      ),
                    );
                  },
                  fallback: (_) =>
                      Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(5.0.sp),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    height: 140.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.grey.shade400.withOpacity(
                                          0.4),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20.0, end: 20.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 0.5.sp,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    height: 140.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20.0, end: 20.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 0.5.sp,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    height: 140.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20.0, end: 20.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 0.5.sp,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    height: 140.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20.0, end: 20.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 0.5.sp,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  // _pushForRequestDetail(UserNotificationApi notification){
  //   if(notification.serviceID!.contains(RequestServiceID.vacationServiceID)){
  //     Navigator.of(context)
  //         .pushNamed(VacationScreen.routeName,arguments: {VacationScreen.requestNoKey: notification.requestNo,VacationScreen.requesterHRCode:notification.requestHRCode});
  //   }else if(notification.serviceID!.contains(RequestServiceID.businessMissionServiceID)){
  //     Navigator.of(context)
  //         .pushNamed(BusinessMissionScreen.routeName,arguments: {BusinessMissionScreen.requestNoKey: notification.requestNo});
  //   }else if (notification.serviceID!.contains(RequestServiceID.permissionServiceID)){
  //     Navigator.of(context)
  //         .pushNamed(PermissionScreen.routeName,arguments: {PermissionScreen.requestNoKey: notification.requestNo.toString()});
  //   }else if (notification.serviceID!.contains(RequestServiceID.embassyServiceID)){
  //     Navigator.of(context)
  //         .pushNamed(EmbassyLetterScreen.routeName,arguments: {EmbassyLetterScreen.requestNoKey: notification.requestNo});
  //   }
  // }

  _pushForRequestDetail(BuildContext context,
      UserNotificationApi notification) {
    switch (notification.serviceID) {
      case RequestServiceID.vacationServiceID:
        {
          Navigator.of(context)
              .pushNamed(VacationScreen.routeName, arguments: {
            VacationScreen.requestNoKey: notification.requestNo.toString(),
            VacationScreen.requesterHRCode: notification.requestHRCode
          });
          break;
        }
      case RequestServiceID.permissionServiceID:
        {
          Navigator.of(context)
              .pushNamed(PermissionScreen.routeName, arguments: {
            PermissionScreen.requestNoKey: notification.requestNo.toString(),
            PermissionScreen.requesterHRCode: notification.requestHRCode
          });
          break;
        }
      case RequestServiceID.businessMissionServiceID:
        {
          Navigator.of(context)
              .pushNamed(BusinessMissionScreen.routeName, arguments: {
            BusinessMissionScreen.requestNoKey: notification.requestNo
                .toString(),
            BusinessMissionScreen.requesterHRCode: notification.requestHRCode
          });
          break;
        }
      case RequestServiceID.embassyServiceID:
        {
          Navigator.of(context)
              .pushNamed(EmbassyLetterScreen.routeName, arguments: {
            EmbassyLetterScreen.requestNoKey: notification.requestNo.toString()
          });
          break;
        }
      case RequestServiceID.accessRightServiceID:
        {
          Navigator.of(context)
              .pushNamed(AccessRightScreen.routeName, arguments: {
            AccessRightScreen.requestNoKey: notification.requestNo.toString()
            ,
            AccessRightScreen.requestHrCode: notification.requestHRCode
                .toString()
          });
          break;
        }
      case RequestServiceID.emailUserAccountServiceID:
        {
          Navigator.of(context)
              .pushNamed(EmailAndUserAccountScreen.routeName, arguments: {
            EmailAndUserAccountScreen.requestNoKey: notification.requestNo
                .toString()
            ,
            EmailAndUserAccountScreen.requestHrCode: notification.requestHRCode
                .toString()
          });
          break;
        }
      case RequestServiceID.businessCardServiceID:
        {
          Navigator.of(context)
              .pushNamed(BusinessCardScreen.routeName, arguments: {
            BusinessCardScreen.requestNoKey: notification.requestNo.toString()
            ,
            BusinessCardScreen.requestHrCode: notification.requestHRCode
                .toString()
          });
          break;
        }
      case RequestServiceID.equipmentServiceID:
        {
          Navigator.of(context)
              .pushNamed(EquipmentsRequest.routeName, arguments: {
            EquipmentsRequest.requestNoKey: notification.requestNo.toString(),
            EquipmentsRequest.requesterHrCode: notification.requestHRCode
                .toString()
          });
          break;
        }
    }
  }
}
