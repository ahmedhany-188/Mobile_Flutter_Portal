part of 'business_card_cubit.dart';

@immutable
abstract class BusinessCardState  extends Equatable{

  const BusinessCardState();
  const BusinessCardState.copyWith({
    required  RequestDate employeeNameCard,required RequestDate employeeMobile,
    required FormzStatus status});
}

class BusinessCardInitial  extends BusinessCardState {
  const BusinessCardInitial({

    this.requestDate = const RequestDate.pure(),
    this.employeeNameCard = const RequestDate.pure(),
    this.employeeMobile = const RequestDate.pure(),
    this.employeeExt = "",
    this.employeeFaxNO = "",
    this.comment = "",
    this.requestStatus ,
    this.status = FormzStatus.pure,
    this.takeActionStatus,
    this.statusAction,
    this.errorMessage,
    this.successMessage,
    this.requesterData = EmployeeData.empty,
    this.actionComment = "",

  });

  final RequestDate requestDate;
  final RequestDate employeeNameCard;
  final RequestDate employeeMobile;
  final String employeeExt;
  final String employeeFaxNO;
  final String comment;
  final RequestStatus? requestStatus;
  final FormzStatus status;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final String? errorMessage;
  final String? successMessage;
  final EmployeeData requesterData;
  final String actionComment;

  @override
  List<Object> get props =>
      [requestDate,
        employeeNameCard,
        employeeMobile,
        employeeExt,
        employeeFaxNO,
        comment,
        status,
  requesterData,actionComment
      ];


  BusinessCardInitial copyWith({
    RequestDate? requestDate,
    RequestDate ?employeeNameCard,
    RequestDate ?employeeMobile,
    String ?employeeExt,
    String ?employeeFaxNO,
    String ?comment,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
    String? statusAction,
    TakeActionStatus? takeActionStatus,
    EmployeeData? requesterData,
    String? actionComment,
  }) {
    return BusinessCardInitial(
      requestDate: requestDate ?? this.requestDate,
      employeeNameCard: employeeNameCard ?? this.employeeNameCard,
      employeeMobile: employeeMobile ?? this.employeeMobile,
      employeeExt: employeeExt ?? this.employeeExt,
      employeeFaxNO: employeeFaxNO ?? this.employeeFaxNO,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      statusAction: statusAction ?? this.statusAction,
      requestStatus: requestStatus ?? this.requestStatus,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }
}



