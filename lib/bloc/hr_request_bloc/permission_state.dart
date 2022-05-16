part of 'permission_cubit.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  PermissionState.copyWith({required RequestDate requestDate, required FormzStatus status}) {}
}

class PermissionInitial extends PermissionState {

  const PermissionInitial({
    this.requestDate = const RequestDate.pure(),
    this.permissionDate = const PermissionDate.pure(),
    this.permissionType = const PermissionType.pure(),
    this.permissionTime = const PermissionTime.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.requestStatus,
  });

  final RequestDate requestDate;
  final PermissionDate permissionDate;
  final PermissionType permissionType;
  final PermissionTime permissionTime;
  final FormzStatus status;
  final String? errorMessage;
  final RequestStatus? requestStatus;

  @override
  List<Object> get props => [requestDate, permissionDate,permissionType,permissionTime, status];

  PermissionInitial copyWith({
    RequestDate? requestDate,
    PermissionDate? permissionDate,
    PermissionType? permissionType,
    PermissionTime? permissionTime,
    FormzStatus? status,
    String? errorMessage,
    RequestStatus? requestStatus
  }) {
    return PermissionInitial(
      requestDate: requestDate ?? this.requestDate,
      permissionDate: permissionDate ?? this.permissionDate,
      permissionType: permissionType ?? this.permissionType,
      permissionTime: permissionTime ?? this.permissionTime,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestStatus: requestStatus ?? this.requestStatus

    );
  }
}
enum RequestStatus {
  newRequest,
  oldRequest,
}


