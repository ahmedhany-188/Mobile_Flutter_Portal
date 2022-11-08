part of 'portal_assistant_cubit.dart';

abstract class PortalAssistantState extends Equatable {
  const PortalAssistantState();
}

enum PortalAssistantEnumStates { initial, success, filtered, failed }

class PortalAssistantInitial extends PortalAssistantState {
  final PortalAssistantEnumStates portalAssistantStates;
  final List<ChatMessage> listQuestions;
  // final List<ChatMessage> tempQuestionsList;
  const PortalAssistantInitial({
    this.portalAssistantStates = PortalAssistantEnumStates.initial,
    this.listQuestions = const <ChatMessage>[],
    // this.tempQuestionsList = const <ChatMessage>[],
  });

  PortalAssistantInitial copyWith({
    PortalAssistantEnumStates? portalAssistantStates,
    List<ChatMessage>? listQuestions,
    // List<ChatMessage>? tempQuestionsList,
  }) {
    return PortalAssistantInitial(
      portalAssistantStates:
          portalAssistantStates ?? this.portalAssistantStates,
      listQuestions: listQuestions ?? this.listQuestions,
      // tempQuestionsList: tempQuestionsList ?? this.tempQuestionsList,
    );
  }

  @override
  List<Object> get props => [
        portalAssistantStates,
        listQuestions,
        // tempQuestionsList,
      ];

  Map<String, dynamic> toMap() {
    return {
      'portalAssistantStates': portalAssistantStates,
      'listQuestions': listQuestions,
    };
  }

  factory PortalAssistantInitial.fromMap(Map<String, dynamic> map) {
    return PortalAssistantInitial(
      portalAssistantStates:
          map['portalAssistantStates'] as PortalAssistantEnumStates,
      listQuestions: map['listQuestions'] as List<ChatMessage>,
    );
  }
}
