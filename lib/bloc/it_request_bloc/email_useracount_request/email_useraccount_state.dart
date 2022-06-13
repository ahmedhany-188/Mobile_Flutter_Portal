part of 'email_useraccount_cubit.dart';

@immutable
abstract class EmailUserAccountState {

  const EmailUserAccountState();

  const EmailUserAccountState.copywith({
  // ignore: non_constant_identifier_names
  required RequestPhoneNumber,required FormzStatus status});
}


class EmailUserAccountInitial extends EmailUserAccountState {

  const EmailUserAccountInitial({

    this.requestType=1,
    this.hrCodeUser,
    this.fullName,
    this.userTitle,
    this.userLocation,
    this.userMobile = const RequestDate.pure(),
    this.accountType=false,
    this.comments,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,

  });

  final int ?requestType;
  final String ?hrCodeUser;
  final String ?fullName;
  final String ?userTitle;
  final String ?userLocation;
  final RequestDate userMobile;
  final bool accountType;
  final String ?comments;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;


  @override
  List<Object> get props => [ userMobile, status,];

  EmailUserAccountInitial copyWith({
    int ?requestType,
    String ?hrCodeUser,
    String ?fullName,
    String ?userTitle,
    String ?userLocation,
    RequestDate ?userMobile,
    bool ?accountType,
    String ?comments,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,

  }) {
    return EmailUserAccountInitial(
      requestType: requestType ?? this.requestType,
      hrCodeUser: hrCodeUser ?? this.hrCodeUser,
      fullName: fullName ?? this.fullName,
      userTitle: userTitle ?? this.userTitle,
      userLocation: userLocation ?? this.userLocation,
      userMobile: userMobile ?? this.userMobile,
      accountType: accountType ?? this.accountType,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,

    );
  }

}
