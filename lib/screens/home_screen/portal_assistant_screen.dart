import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/helper_bot_screen_bloc/portal_assistant_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

class PortalAssistantScreen extends StatelessWidget {
  PortalAssistantScreen({Key? key}) : super(key: key);
  static const routeName = 'Chatbot-screen';

  bool shouldType = false;
//   @override
//   State<FloatingChatbot> createState() => _FloatingChatbotState();
// }
//
//
//
// class _FloatingChatbotState extends State<FloatingChatbot> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
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
                messageOptions: MessageOptions(
                  showOtherUsersName: false,
                  currentUserContainerColor:
                      ConstantsColors.bottomSheetBackgroundDark,
                  containerColor: ConstantsColors.whiteNormalAttendance,
                  showTime: true,
                  messageTextBuilder: (message, previousMessage, nextMessage) {
                    return (message.user ==
                            PortalAssistantCubit.get(ctx).currentChatUser)
                        ? Text(
                            message.text,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            message.text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          );
                  },
                  textColor: Colors.black,
                  onTapMedia: (media) {
                    shouldType = true;
                    PortalAssistantCubit.get(ctx).startAddingTempMessages([
                      ...state.listQuestions
                    ]..insert(
                        0,
                        ChatMessage(
                            user: PortalAssistantCubit.get(ctx).currentChatUser,
                            createdAt: DateTime.now(),
                            text: media.fileName)));

                    if (media.fileName == 'IT FAQ') {
                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          shouldType = false;
                          PortalAssistantCubit.get(ctx).startAddingTempMessages(
                            [...state.listQuestions]..insertAll(0, [
                                ChatMessage(
                                    user: PortalAssistantCubit.get(ctx)
                                        .allamAssistant,
                                    createdAt: DateTime.now(),
                                    text:
                                        "How can i reset portal password?\ni don't know"),
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

                    //
                    // if (media.fileName == 'HR FAQ') {}
                  },
                  onPressMessage: (p0) {},
                ),
                onSend: (m) {},
              ),
            ),
          );
        },
      ),
    )));
  }
}
