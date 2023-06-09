part of 'embassy_letter_cubit.dart';

@immutable
abstract class EmbassyLetterState extends Equatable {

  const EmbassyLetterState();

  const EmbassyLetterState.copyWith({
    required RequestDate dateFrom ,required RequestDate dateTo
    , required RequestDate passportNumber, required FormzStatus status});
}

class EmbassyLetterInitial extends EmbassyLetterState {
  const EmbassyLetterInitial({
    this.requestDate = const RequestDate.pure(),
    this.purpose = "Tourism",
    this.embassy = "0",
    this.embassyID="1",
    this.dateFrom = const RequestDate.pure(),
    this.dateTo = const RequestDate.pure(),
    this.passportNumber = const PassportNumber.pure(),
    this.salary = "Yes",
    this.comments="",
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.statusAction,
    this.takeActionStatus,
    this.requestStatus,
    this.requesterData = EmployeeData.empty,
    this.actionComment = "",
  });

  final RequestDate requestDate;

  final String purpose;
  final String embassy;
  final String embassyID;

  final RequestDate dateFrom;
  final RequestDate dateTo;
  final PassportNumber passportNumber;
  final String salary;
  final String comments;

  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;

  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final RequestStatus? requestStatus;

  final EmployeeData requesterData;
  final String actionComment;

  @override
  List<Object> get props => [requestDate,dateFrom, dateTo,
    passportNumber, status,embassy,
    salary,comments,requesterData,actionComment];


  EmbassyLetterInitial copyWith({
    RequestDate? requestDate,
    String ?purpose,
    String ?embassy,
    String ?embassyID,
    RequestDate ?dateFrom,
    RequestDate ?dateTo,
    PassportNumber? passportNumber,
    String ?salary,
    String ?comments,
    FormzStatus ?status,
    String? errorMessage,
    String? successMessage,

    TakeActionStatus? takeActionStatus,
    String? statusAction,
    RequestStatus? requestStatus,

    EmployeeData? requesterData,
    String? actionComment,

  }) {
    return EmbassyLetterInitial(
      requestDate: requestDate ?? this.requestDate,
      purpose: purpose ?? this.purpose,
      embassy: embassy ?? this.embassy,
      embassyID: embassyID ?? this.embassyID,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      passportNumber: passportNumber ?? this.passportNumber,
      salary: salary ?? this.salary,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      statusAction: statusAction ?? this.statusAction,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }

}
