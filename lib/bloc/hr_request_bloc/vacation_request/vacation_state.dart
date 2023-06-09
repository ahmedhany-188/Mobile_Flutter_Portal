part of 'vacation_cubit.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  const PermissionState.copyWith({required RequestDate requestDate, required FormzStatus status});
}

class VacationInitial extends Equatable {

  const VacationInitial({
    this.requestDate = const RequestDate.pure(),
    this.vacationFromDate = const DateFrom.pure(),
    this.vacationToDate = const DateTo.pure(),
    this.vacationType = 1,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.requestStatus,
    this.comment = "",
    this.actionComment = "",
    this.responsiblePerson = ContactsDataFromApi.empty,
    this.vacationDuration ="",
    this.takeActionStatus,
    this.statusAction,
    this.requesterData = EmployeeData.empty,
  });

  final RequestDate requestDate;
  final DateFrom vacationFromDate;
  final DateTo vacationToDate;
  final int vacationType;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;
  final ContactsDataFromApi responsiblePerson;
  final String comment;
  final String vacationDuration;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final EmployeeData requesterData;
  final String actionComment;

  @override
  List<Object> get props => [requestDate, vacationFromDate,vacationToDate,vacationType, status,comment,responsiblePerson,vacationDuration,requesterData,actionComment];

  VacationInitial copyWith({
    RequestDate? requestDate,
    DateFrom? vacationFromDate,
    DateTo? vacationToDate,
    int? vacationType,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
    String? comment,
    String? actionComment,
    String? vacationDuration,
    ContactsDataFromApi? responsiblePerson,
    TakeActionStatus? takeActionStatus,
    String? statusAction,
    EmployeeData? requesterData,
  }) {
    return VacationInitial(
      requestDate: requestDate ?? this.requestDate,
      vacationFromDate: vacationFromDate ?? this.vacationFromDate,
      vacationToDate: vacationToDate ?? this.vacationToDate,
      vacationType: vacationType ?? this.vacationType,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      comment: comment ?? this.comment,
      responsiblePerson: responsiblePerson ?? this.responsiblePerson,
      vacationDuration: vacationDuration ?? this.vacationDuration,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      statusAction: statusAction ?? this.statusAction,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }
}


