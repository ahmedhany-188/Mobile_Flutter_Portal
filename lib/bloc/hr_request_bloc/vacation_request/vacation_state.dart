part of 'vacation_cubit.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  PermissionState.copyWith({required RequestDate requestDate, required FormzStatus status}) {}
}

class VacationInitial extends PermissionState {

  const VacationInitial({
    this.requestDate = const RequestDate.pure(),
    this.vacationFromDate = const VacationDate.pure(),
    this.vacationToDate = const VacationDateTo.pure(),
    this.vacationType = 1,
    this.permissionTime = const PermissionTime.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.requestStatus,
    this.comment = "",
    this.responsiblePerson = ContactsDataFromApi.empty,
    this.vacationDuration = "0"
  });

  final RequestDate requestDate;
  final VacationDate vacationFromDate;
  final VacationDateTo vacationToDate;
  final int vacationType;
  final PermissionTime permissionTime;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;
  final ContactsDataFromApi responsiblePerson;
  final String comment;
  final String vacationDuration;

  @override
  List<Object> get props => [requestDate, vacationFromDate,vacationToDate,vacationType,permissionTime, status,comment,vacationDuration,responsiblePerson];

  VacationInitial copyWith({
    RequestDate? requestDate,
    VacationDate? vacationFromDate,
    VacationDateTo? vacationToDate,
    int? vacationType,
    PermissionTime? permissionTime,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
    String? comment,
    String? vacationDuration,
    ContactsDataFromApi? responsiblePerson,
  }) {
    return VacationInitial(
      requestDate: requestDate ?? this.requestDate,
      vacationFromDate: vacationFromDate ?? this.vacationFromDate,
      vacationToDate: vacationToDate ?? this.vacationToDate,
      vacationType: vacationType ?? this.vacationType,
      permissionTime: permissionTime ?? this.permissionTime,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      comment: comment ?? this.comment,
      responsiblePerson: responsiblePerson ?? this.responsiblePerson,
      vacationDuration: vacationDuration ?? this.vacationDuration,

    );
  }
}


