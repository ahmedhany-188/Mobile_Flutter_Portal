part of 'permission_cubit.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  const PermissionState.copyWith({required RequestDate requestDate, required FormzStatus status});
}

class PermissionInitial extends PermissionState {

  const PermissionInitial({
    this.requestDate = const RequestDate.pure(),
    this.permissionDate = const PermissionDate.pure(),
    this.permissionType = 0,
    this.permissionTime = const PermissionTime.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.successMessage,
    this.requestStatus,
    this.comment = "",
    this.statusAction,
    this.takeActionStatus,
    this.requesterData = EmployeeData.empty,
    this.actionComment = "",
  });

  final RequestDate requestDate;
  final PermissionDate permissionDate;
  final int permissionType;
  final PermissionTime permissionTime;
  final FormzStatus status;
  final String? errorMessage;
  final String? successMessage;
  final RequestStatus? requestStatus;
  final String comment;
  final TakeActionStatus? takeActionStatus;
  final String? statusAction;
  final EmployeeData requesterData;
  final String actionComment;

  @override
  List<Object> get props =>
      [requestDate, permissionDate,
        permissionType, permissionTime, status, comment,actionComment];

  PermissionInitial copyWith({
    RequestDate? requestDate,
    PermissionDate? permissionDate,
    int? permissionType,
    PermissionTime? permissionTime,
    FormzStatus? status,
    String? errorMessage,
    String? successMessage,
    RequestStatus? requestStatus,
    String? comment,
    TakeActionStatus? takeActionStatus,
    String? statusAction,
    EmployeeData? requesterData,
    String? actionComment,
  }) {
    return PermissionInitial(
      requestDate: requestDate ?? this.requestDate,
      permissionDate: permissionDate ?? this.permissionDate,
      permissionType: permissionType ?? this.permissionType,
      permissionTime: permissionTime ?? this.permissionTime,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      comment: comment ?? this.comment,
      statusAction: statusAction ?? this.statusAction,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }
}



