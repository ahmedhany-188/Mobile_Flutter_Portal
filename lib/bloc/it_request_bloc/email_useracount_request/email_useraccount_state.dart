part of 'email_useraccount_cubit.dart';

@immutable
abstract class EmailUserAccountState extends Equatable{
  const EmailUserAccountState();
  const EmailUserAccountState.copyWith({
  required requestPhoneNumber,required hrCodeUser,required FormzStatus status});
}


class EmailUserAccountInitial extends Equatable {

  const EmailUserAccountInitial({

    this.requestDate = const RequestDate.pure(),
    this.requestType = 1,
    this.hrCodeUser = const RequestDate.pure(),
    this.fullName = "",
    this.userTitle = "",
    this.userLocation = "",
    this.email = "",
    this.userMobile = const RequestDate.pure(),
    this.accountType = false,
    this.comments = "",
    this.requestStatus,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.takeActionStatus,
    this.statusAction,
    this.requesterData = EmployeeData.empty,
    this.actionComment = "",

  });

  final RequestDate requestDate;
  final int requestType;
  final RequestDate hrCodeUser;
  final String fullName;
  final String userTitle;
  final String userLocation;
  final String email;
  final RequestDate userMobile;
  final RequestStatus? requestStatus;
  final bool accountType;
  final String comments;
  final FormzStatus status;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final String? errorMessage;
  final String? successMessage;
  final EmployeeData requesterData;
  final String actionComment;

  @override
  List<Object> get props =>
      [userMobile,
        hrCodeUser,
        status,
        requestType,
        accountType,
        comments,
        fullName, userTitle, userLocation, email,
        requesterData, actionComment
      ];

  EmailUserAccountInitial copyWith({
    RequestDate? requestDate,
    int ?requestType,
    RequestDate ?hrCodeUser,
    String ?fullName,
    String ?userTitle,
    String ?userLocation,
    String ?email,
    RequestDate ?userMobile,
    RequestStatus? requestStatus,
    bool ?accountType,
    String ?comments,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,
    TakeActionStatus? takeActionStatus,
    String? statusAction,
    EmployeeData? requesterData,
    String? actionComment,
  }) {
    return EmailUserAccountInitial(
      requestDate: requestDate ?? this.requestDate,
      requestType: requestType ?? this.requestType,
      hrCodeUser: hrCodeUser ?? this.hrCodeUser,
      fullName: fullName ?? this.fullName,
      userTitle: userTitle ?? this.userTitle,
      userLocation: userLocation ?? this.userLocation,
      email: email ?? this.email,
      userMobile: userMobile ?? this.userMobile,
      accountType: accountType ?? this.accountType,
      requestStatus: requestStatus ?? this.requestStatus,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      statusAction: statusAction ?? this.statusAction,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }
}
