import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../gen/fonts.gen.dart';
import '../../gen/assets.gen.dart';
import '../../constants/enums.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/url_links.dart';
import '../../constants/request_service_id.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../it_requests_screen/access_right_screen.dart';
import '../admin_request_screen/business_card_screen.dart';
import '../admin_request_screen/embassy_letter_screen.dart';
import '../it_requests_screen/equipments_request_screen.dart';
import '../it_requests_screen/email_and_useraccount_screen.dart';
import '../../data/models/user_notification_api/user_notification_api.dart';
import '../hr_requests_screen/vacation_request_screen/vacation_screen.dart';
import '../../bloc/notification_bloc/cubit/user_notification_api_cubit.dart';
import '../hr_requests_screen/permission_request_screen/permission_screen.dart';
import '../hr_requests_screen/business_mission_request_screen/business_mission_screen.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.listFromnotificationScreen})
      : super(key: key);

  final List<UserNotificationApi> listFromnotificationScreen;

  @override
  Widget build(BuildContext context) {
    final userMainData = context.select((AppBloc bloc) => bloc.state.userData);
    return ConditionalBuilder(
      condition: (UserNotificationApiCubit.get(context)
                  .state
                  .userNotificationEnumStates ==
              UserNotificationEnumStates.success ||
          (UserNotificationApiCubit.get(context)
                      .state
                      .userNotificationEnumStates ==
                  UserNotificationEnumStates.noConnection &&
              UserNotificationApiCubit.get(context)
                  .state
                  .userNotificationList
                  .isNotEmpty) ||
          (UserNotificationApiCubit.get(context)
                      .state
                      .userNotificationEnumStates ==
                  UserNotificationEnumStates.failed &&
              listFromnotificationScreen.isNotEmpty)),
      builder: (_) {
        return listFromnotificationScreen.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listFromnotificationScreen.length,
                  itemBuilder: (ctx, index) {
                    UserNotificationApi notification =
                        listFromnotificationScreen[index];
                    var imageProfile = notification.imgProfile ?? "";
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          _pushForRequestDetail(context, notification);
                        },
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.25,
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey.shade400.withOpacity(0.4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Center(
                                        child: imageProfile.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: getUserProfilePicture(
                                                    imageProfile),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Assets.images.favicon
                                                        .image(height: 40),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Assets.images.favicon
                                                            .image(height: 50),
                                              )
                                            : Assets.images.favicon
                                                .image(height: 40),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${notification.reqName?.toTitleCase()}'
                                                .trim(),
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: FontFamily.robotoFlex,
                                            ),
                                            maxLines: 1,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${notification.projectName}'
                                                .trim(),

                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: FontFamily.robotoFlex,
                                            ),
                                            maxLines: 1,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${notification.requestHRCode}'
                                                .trim(),
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: FontFamily.robotoFlex,
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
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  color: Colors.white,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        ' ${notification.status} ${notification.serviceName} #${notification.requestNo}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontFamily: FontFamily.robotoFlex,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                      // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                      Text(
                                        'comment: ${notification.reqComment}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontFamily: FontFamily.robotoFlex,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (notification.requestHRCode !=
                                  userMainData.employeeData?.userHrCode)
                                Flexible(
                                  flex: 1,
                                  // padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              UserNotificationApiCubit>(
                                                          context)
                                                      .submitRequestAction(
                                                          ActionValueStatus
                                                              .accept,
                                                          notification);
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        ConstantsColors
                                                            .buttonColors),
                                                child: const Text('Accept',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                // color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            // MyRequestStatus(listFromRequestScreen[index].statusName.toString(), context),
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  if (notification.serviceID ==
                                                      RequestServiceID
                                                          .equipmentServiceID) {
                                                    TextEditingController
                                                        actionCommentController =
                                                        TextEditingController();
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              ConstantsColors
                                                                  .bottomSheetBackground,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          title: Row(
                                                            children: const [
                                                              Icon(
                                                                Icons.warning,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              Padding(padding: EdgeInsets.all(8)),
                                                              Text(
                                                                  "Please add a comment"),
                                                            ],
                                                          ),
                                                          content: SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  actionCommentController,
                                                              enabled: true,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              maxLines: 3,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                                filled: true,
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        800]),
                                                                labelText:
                                                                    "Action comment",
                                                                prefixIcon:
                                                                    const Icon(
                                                                  Icons.comment,
                                                                  color: Colors
                                                                      .white70,
                                                                ),
                                                                enabled: true,
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                if (actionCommentController
                                                                    .text
                                                                    .isEmpty) {
                                                                  EasyLoading
                                                                      .showError(
                                                                          'Add a comment');
                                                                } else {
                                                                  BlocProvider.of<
                                                                              UserNotificationApiCubit>(
                                                                          context)
                                                                      .submitRequestAction(
                                                                    ActionValueStatus
                                                                        .reject,
                                                                    notification,
                                                                    actionComment:
                                                                        actionCommentController
                                                                            .text,
                                                                  );
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                              child: const Text(
                                                                'Continue Reject',
                                                                style: TextStyle(
                                                                    color: ConstantsColors
                                                                        .greenAttendance),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    BlocProvider.of<
                                                                UserNotificationApiCubit>(
                                                            context)
                                                        .submitRequestAction(
                                                            ActionValueStatus
                                                                .reject,
                                                            notification);
                                                  }
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                                child: const Text(
                                                  'Reject',
                                                  style: TextStyle(
                                                      color: ConstantsColors
                                                          .buttonColors),
                                                ),

                                                // color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          GlobalConstants
                                              .dateFormatViewedDaysAndHours
                                              .format(GlobalConstants
                                                  .dateFormatServer
                                                  .parse(notification.reqDate ??
                                                      "")),
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white,
                                            fontFamily: FontFamily.robotoFlex,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
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
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 20.0, end: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text('No Data Found'),
              );
      },
      fallback: (_) => Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey.shade400.withOpacity(0.4),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_pushForRequestDetail(BuildContext context, UserNotificationApi notification) {
  switch (notification.serviceID) {
    case RequestServiceID.vacationServiceID:
      {
        Navigator.of(context).pushNamed(VacationScreen.routeName, arguments: {
          VacationScreen.requestNoKey: notification.requestNo.toString(),
          VacationScreen.requesterHRCode: notification.requestHRCode
        });
        break;
      }
    case RequestServiceID.permissionServiceID:
      {
        Navigator.of(context).pushNamed(PermissionScreen.routeName, arguments: {
          PermissionScreen.requestNoKey: notification.requestNo.toString(),
          PermissionScreen.requesterHRCode: notification.requestHRCode
        });
        break;
      }
    case RequestServiceID.businessMissionServiceID:
      {
        Navigator.of(context)
            .pushNamed(BusinessMissionScreen.routeName, arguments: {
          BusinessMissionScreen.requestNoKey: notification.requestNo.toString(),
          BusinessMissionScreen.requesterHRCode: notification.requestHRCode
        });
        break;
      }
    case RequestServiceID.embassyServiceID:
      {
        Navigator.of(context)
            .pushNamed(EmbassyLetterScreen.routeName, arguments: {
          EmbassyLetterScreen.requestNoKey: notification.requestNo.toString(),
          EmbassyLetterScreen.requesterHRCode: notification.requestHRCode
        });
        break;
      }
    case RequestServiceID.accessRightServiceID:
      {
        Navigator.of(context)
            .pushNamed(AccessRightScreen.routeName, arguments: {
          AccessRightScreen.requestNoKey: notification.requestNo.toString(),
          AccessRightScreen.requesterHRCode:
              notification.requestHRCode.toString()
        });
        break;
      }
    case RequestServiceID.emailUserAccountServiceID:
      {
        Navigator.of(context)
            .pushNamed(EmailAndUserAccountScreen.routeName, arguments: {
          EmailAndUserAccountScreen.requestNoKey:
              notification.requestNo.toString(),
          EmailAndUserAccountScreen.requesterHRCode:
              notification.requestHRCode.toString()
        });
        break;
      }
    case RequestServiceID.businessCardServiceID:
      {
        Navigator.of(context)
            .pushNamed(BusinessCardScreen.routeName, arguments: {
          BusinessCardScreen.requestNoKey: notification.requestNo.toString(),
          BusinessCardScreen.requesterHRCode:
              notification.requestHRCode.toString()
        });
        break;
      }
    case RequestServiceID.equipmentServiceID:
      {
        Navigator.of(context)
            .pushNamed(EquipmentsRequestScreen.routeName, arguments: {
          EquipmentsRequestScreen.requestNoKey:
              notification.requestNo.toString(),
          EquipmentsRequestScreen.requesterHrCode:
              notification.requestHRCode.toString(),
          "date": notification.reqDate
        });
        break;
      }
  }
}
