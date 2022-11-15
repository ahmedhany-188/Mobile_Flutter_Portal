import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/data_providers/general_dio/general_dio.dart';

part 'portal_assistant_state.dart';

class PortalAssistantCubit extends Cubit<PortalAssistantInitial> with HydratedMixin{
  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  PortalAssistantCubit(this._generalDio)
      : super(const PortalAssistantInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.portalAssistantStates == PortalAssistantEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getQuestions();
          } catch (e) {
            emit(state.copyWith(
              portalAssistantStates: PortalAssistantEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            portalAssistantStates: PortalAssistantEnumStates.failed,
          ));
        }
      }
    });
  }

  static PortalAssistantCubit get(context) => BlocProvider.of(context);
  ChatUser allamAssistant = ChatUser(
    id: '0',
    firstName: 'Portal',
    lastName: 'Assistant',
    profileImage: 'https://portal.hassanallam.com/images/imgs/3340.jpg'
  );
  ChatUser currentChatUser = ChatUser(
    id: '1',
    firstName: '',
    lastName: '',
  );

  void getQuestions() {
    emit(state.copyWith(
      // portalAssistantStates: PortalAssistantEnumStates.success,
      listQuestions: [
        ChatMessage(
          user: allamAssistant,
          createdAt: DateTime.now(),
          medias: [
            ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'IT FAQ', type: MediaType.image),
            ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'HR FAQ', type: MediaType.image),
            ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'HR FAQ', type: MediaType.image),
            ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'HR FAQ', type: MediaType.image),
          ],
        ),
        ChatMessage(
          text: 'Hello!\nHere is a scoop to choose from..',
          user: allamAssistant,
          createdAt: DateTime.now(),
        ),
      ],
    ));
  }

  void startAddingTempMessages(List<ChatMessage> newMessage) {
    // List<ChatMessage> tempo = state.listQuestions;
    // tempo.insert(0, newMessage);
    emit(state.copyWith(
      listQuestions: newMessage
      // [
      //   ChatMessage(
      //     user: allamAssistant,
      //     createdAt: DateTime.now(),
      //     medias: [
      //       ChatMedia(url: '', fileName: 'IT FAQ', type: MediaType.file),
      //       ChatMedia(url: '', fileName: 'HR FAQ', type: MediaType.file),
      //     ],
      //   ),
      //   ChatMessage(
      //     text: '5555555555555 A7a!',
      //     user: allamAssistant,
      //     createdAt: DateTime.now(),
      //   ),
      // ],
    ));

  }

  void backToInitialConversation() {
    emit(state.copyWith(
        listQuestions: [
      ChatMessage(
        user: allamAssistant,
        createdAt: DateTime.now(),
        medias: [
          ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'IT FAQ', type: MediaType.image),
          ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'HR FAQ', type: MediaType.image),
          ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'HR FAQ', type: MediaType.image),
          ChatMedia(url: 'https://portal.hassanallam.com/images/imgs/3340.jpg', fileName: 'HR FAQ', type: MediaType.image),
        ],
      ),
      ChatMessage(
        text: 'Hello!\nHere is a scoop to choose from..',
        user: allamAssistant,
        createdAt: DateTime.now(),
      ),
    ]));
  }

  @override
  PortalAssistantInitial? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(PortalAssistantInitial state) {
    // TODO: implement toJson
    if (state.portalAssistantStates == PortalAssistantEnumStates.success &&
        state.listQuestions.isNotEmpty) {
      return state.toMap();
    } else {
      return null;
    }
    // throw UnimplementedError();
  }
}
