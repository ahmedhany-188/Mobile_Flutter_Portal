part of 'business_mission_cubit.dart';

abstract class BusinessMissionState extends Equatable {
  const BusinessMissionState();

  BusinessMissionState.copyWith({required RequestDate requestDate, required FormzStatus status}) {}
}

class BusinessMissionInitial extends BusinessMissionState {

  const BusinessMissionInitial({
    this.requestDate = const RequestDate.pure(),
    this.dateFrom = const DateFrom.pure(),
    this.dateTo = const DateTo.pure(),
    this.missionType = 1,
    this.timeFrom = const TimeFrom.pure(),
    this.timeTo = const TimeTo.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.requestStatus,
    this.comment = "",
  });

  final RequestDate requestDate;
  final DateFrom dateFrom;
  final DateTo dateTo;
  final int missionType;
  final TimeFrom timeFrom;
  final TimeTo timeTo;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;
  final String comment;

  @override
  List<Object> get props => [requestDate, dateFrom,dateTo,missionType,timeFrom,timeTo, status,comment];

  BusinessMissionInitial copyWith({
    RequestDate? requestDate,
    DateFrom? dateFrom,
    DateTo? dateTo,
    int? missionType,
    TimeFrom? timeFrom,
    TimeTo? timeTo,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
    String? comment,
  }) {
    return BusinessMissionInitial(
      requestDate: requestDate ?? this.requestDate,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      missionType: missionType ?? this.missionType,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      comment: comment ?? this.comment,

    );
  }
}



