import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/helper_bot_screen_bloc/portal_assistant_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/screens/employee_appraisal_screen/employee_appraisal_screen.dart';
import 'package:hassanallamportalflutter/screens/myattendance_screen/attendance_screen.dart';
import 'package:hassanallamportalflutter/screens/payslip_screen/payslip_screen.dart';
import 'package:hassanallamportalflutter/screens/projects_portfolio/projects_portfolio_screen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PortalAssistantScreen extends StatelessWidget {
  PortalAssistantScreen({Key? key}) : super(key: key);
  static const routeName = 'Chatbot-screen';

  bool shouldType = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: CustomBackground(
          child: CustomTheme(
              child: BlocProvider<PortalAssistantCubit>.value(
        value: PortalAssistantCubit.get(context),
        child: BlocBuilder<PortalAssistantCubit, PortalAssistantInitial>(
          builder: (ctx, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Portal Assistant'),
                actions: [
                  IconButton(
                    onPressed: () {
                      PortalAssistantCubit.get(ctx).backToInitialConversation();
                    },
                    icon: const Icon(Icons.cached_rounded),
                  )
                ],
              ),
              body: Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: DashChat(
                  currentUser: PortalAssistantCubit.get(ctx).currentChatUser,
                  messages: state.listQuestions,
                  readOnly: true,
                  messageListOptions: const MessageListOptions(
                    scrollPhysics: BouncingScrollPhysics(),
                  ),
                  typingUsers: (shouldType)
                      ? [PortalAssistantCubit.get(ctx).allamAssistant]
                      : [],
                  scrollToBottomOptions: ScrollToBottomOptions(
                    scrollToBottomBuilder: (scrollController) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ConstantsColors.bottomSheetBackgroundDark,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color:
                                    ConstantsColors.bottomSheetBackgroundDark,
                              )
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              scrollController.animateTo(0,
                                  curve: Curves.ease,
                                  duration: const Duration(seconds: 1));
                            },
                            child: const Icon(
                              Icons.arrow_downward,
                              size: 20,
                              color: ConstantsColors.whiteNormalAttendance,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  messageOptions: MessageOptions(
                    showOtherUsersName: false,
                    currentUserContainerColor:
                        ConstantsColors.bottomSheetBackgroundDark,
                    containerColor: ConstantsColors.whiteNormalAttendance,
                    showTime: true,
                    messagePadding: const EdgeInsets.all(10),
                    messageTextBuilder:
                        (message, previousMessage, nextMessage) {
                      return (message.user ==
                              PortalAssistantCubit.get(ctx).currentChatUser)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  message.text,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat.Hm()
                                      .format(message.createdAt)
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  message.text,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  DateFormat.Hm()
                                      .format(message.createdAt)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            );
                    },
                    textColor: Colors.black,
                    onTapMedia: (media) {
                      if (!shouldType) {
                        shouldType = true;
                        PortalAssistantCubit.get(ctx).startAddingTempMessages([
                          ...state.listQuestions
                        ]..insert(
                            0,
                            ChatMessage(
                                user: PortalAssistantCubit.get(ctx)
                                    .currentChatUser,
                                createdAt: DateTime.now(),
                                text: media.fileName)));

                        if (media.fileName == 'Payslip') {
                          Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              shouldType = false;
                              PortalAssistantCubit.get(ctx)
                                  .startAddingTempMessages(
                                [...state.listQuestions]..insertAll(0, [
                                    ChatMessage(
                                      user: PortalAssistantCubit.get(ctx)
                                          .allamAssistant,
                                      createdAt: DateTime.now(),
                                      text: "Click here to download payslip",
                                      customProperties: {'isPayslipAnswer': true},
                                    ),
                                    ChatMessage(
                                      user: PortalAssistantCubit.get(ctx)
                                          .allamAssistant,
                                      createdAt: DateTime.now(),
                                      text: "How can i download payslip?",
                                    ),
                                    ChatMessage(
                                        user: PortalAssistantCubit.get(ctx)
                                            .currentChatUser,
                                        createdAt: DateTime.now(),
                                        text: media.fileName),
                                  ]),
                              );
                            },
                          );
                        }
                        if (media.fileName == 'Attendance') {
                          Future.delayed(
                            const Duration(seconds: 1),
                                () {
                              shouldType = false;
                              PortalAssistantCubit.get(ctx)
                                  .startAddingTempMessages(
                                [...state.listQuestions]..insertAll(0, [
                                  ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text: "Click here to show attendance page",
                                    customProperties: {'isAttendanceAnswer': true},
                                  ),
                                  ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text: "Attendance page?",
                                  ),
                                  ChatMessage(
                                      user: PortalAssistantCubit.get(ctx)
                                          .currentChatUser,
                                      createdAt: DateTime.now(),
                                      text: media.fileName),
                                ]),
                              );
                            },
                          );
                        }
                        if (media.fileName == 'HAH Projects') {
                          Future.delayed(
                            const Duration(seconds: 1),
                                () {
                              shouldType = false;
                              PortalAssistantCubit.get(ctx)
                                  .startAddingTempMessages(
                                [...state.listQuestions]..insertAll(0, [
                                  ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text: "Click here to show HAH projects page",
                                    customProperties: {'isProjectsAnswer': true},
                                  ),
                                  ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text: "HAH projects?",
                                  ),
                                  ChatMessage(
                                      user: PortalAssistantCubit.get(ctx)
                                          .currentChatUser,
                                      createdAt: DateTime.now(),
                                      text: media.fileName),
                                ]),
                              );
                            },
                          );
                        }
                        if (media.fileName == 'Appraisal') {
                          Future.delayed(
                            const Duration(seconds: 1),
                                () {
                              shouldType = false;
                              PortalAssistantCubit.get(ctx)
                                  .startAddingTempMessages(
                                [...state.listQuestions]..insertAll(0, [
                                  ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text: "Click here to show Appraisal page",
                                    customProperties: {'isAppraisalAnswer': true},
                                  ),
                                  ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text: "Appraisal page?",
                                  ),
                                  ChatMessage(
                                      user: PortalAssistantCubit.get(ctx)
                                          .currentChatUser,
                                      createdAt: DateTime.now(),
                                      text: media.fileName),
                                ]),
                              );
                            },
                          );
                        }
                      }
                    },
                    onPressMessage: (p0) {
                      if (p0.text.contains('payslip') &&
                          p0.customProperties?['isPayslipAnswer'] == true) {
                        EasyLoading.show(
                            dismissOnTap: false, status: 'Redirecting...');
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pushReplacementNamed(PayslipScreen.routeName);
                          EasyLoading.dismiss();
                        });
                      }
                      if (p0.text.contains('Appraisal') &&
                          p0.customProperties?['isAppraisalAnswer'] == true) {
                        EasyLoading.show(
                            dismissOnTap: false, status: 'Redirecting...');
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pushReplacementNamed(EmployeeAppraisalScreen.routeName);
                          EasyLoading.dismiss();
                        });
                      }
                      if (p0.text.contains('HAH projects') &&
                          p0.customProperties?['isProjectsAnswer'] == true) {
                        EasyLoading.show(
                            dismissOnTap: false, status: 'Redirecting...');
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pushReplacementNamed(ProjectsPortfolioScreen.routeName);
                          EasyLoading.dismiss();
                        });
                      }
                      if (p0.text.contains('attendance') &&
                          p0.customProperties?['isAttendanceAnswer'] == true) {
                        EasyLoading.show(
                            dismissOnTap: false, status: 'Redirecting...');
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pushReplacementNamed(AttendanceScreen.routeName);
                          EasyLoading.dismiss();
                        });
                      }
                    },

                  ),
                  onSend: (m) {},
                ),
              ),
            );
          },
        ),
      ))),
    );
  }
}
