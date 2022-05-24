part of 'business_mission_cubit.dart';

abstract class BusinessMissionState extends Equatable {
  const BusinessMissionState();

  BusinessMissionState.copyWith({required RequestDate requestDate, required FormzStatus status}) {}
}

class BusinessMissionInitial extends BusinessMissionState {

  const BusinessMissionInitial({
    this.requestDate = const RequestDate.pure(),
    this.permissionDate = const PermissionDate.pure(),
    this.missionType = 1,
    this.permissionTime = const PermissionTime.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.requestStatus,
    this.comment = "",
  });

  final RequestDate requestDate;
  final PermissionDate permissionDate;
  final int missionType;
  final PermissionTime permissionTime;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;
  final String comment;

  @override
  List<Object> get props => [requestDate, permissionDate,missionType,permissionTime, status,comment];

  BusinessMissionInitial copyWith({
    RequestDate? requestDate,
    PermissionDate? permissionDate,
    int? missionType,
    PermissionTime? permissionTime,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
    String? comment,
  }) {
    return BusinessMissionInitial(
      requestDate: requestDate ?? this.requestDate,
      permissionDate: permissionDate ?? this.permissionDate,
      missionType: missionType ?? this.missionType,
      permissionTime: permissionTime ?? this.permissionTime,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      comment: comment ?? this.comment,

    );
  }
}



