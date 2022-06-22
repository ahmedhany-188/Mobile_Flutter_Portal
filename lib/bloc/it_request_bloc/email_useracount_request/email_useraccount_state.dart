part of 'email_useraccount_cubit.dart';

@immutable
abstract class EmailUserAccountState extends Equatable{

  const EmailUserAccountState();

  const EmailUserAccountState.copyWith({
  required requestPhoneNumber,required FormzStatus status});
}


class EmailUserAccountInitial extends Equatable {

  const EmailUserAccountInitial({

    this.requestDate = const RequestDate.pure(),
    this.requestType=1,
    this.hrCodeUser,
    this.fullName,
    this.userTitle,
    this.userLocation,
    this.userMobile = const RequestDate.pure(),
    this.accountType=false,
    this.comments="",
    this.requestStatus,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.takeActionStatus,
    this.statusAction,

  });

  final RequestDate requestDate;
  final int requestType;
  final String ?hrCodeUser;
  final String ?fullName;
  final String ?userTitle;
  final String ?userLocation;
  final RequestDate userMobile;
  final RequestStatus? requestStatus;
  final bool accountType;
  final String comments;
  final FormzStatus status;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final String? errorMessage;
  final String? successMessage;

  @override
  List<Object> get props => [ userMobile, status,requestType,accountType,comments];

  EmailUserAccountInitial copyWith({
    RequestDate? requestDate,
    int ?requestType,
    String ?hrCodeUser,
    String ?fullName,
    String ?userTitle,
    String ?userLocation,
    RequestDate ?userMobile,
    RequestStatus? requestStatus,
    bool ?accountType,
    String ?comments,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,
    TakeActionStatus? takeActionStatus,
    String? statusAction

  }) {
    return EmailUserAccountInitial(
        requestDate: requestDate ?? this.requestDate,
        requestType: requestType ?? this.requestType,
      hrCodeUser: hrCodeUser ?? this.hrCodeUser,
      fullName: fullName ?? this.fullName,
      userTitle: userTitle ?? this.userTitle,
      userLocation: userLocation ?? this.userLocation,
      userMobile: userMobile ?? this.userMobile,
      accountType: accountType ?? this.accountType,
      requestStatus: requestStatus ?? this.requestStatus,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
        statusAction: statusAction ?? this.statusAction


    );
  }

}
