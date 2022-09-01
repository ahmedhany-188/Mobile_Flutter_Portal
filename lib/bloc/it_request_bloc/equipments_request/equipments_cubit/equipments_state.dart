part of 'equipments_cubit.dart';

enum EquipmentsEnumState { initial, success, failed }

class EquipmentsCubitStates extends Equatable {
  final EquipmentsEnumState businessUnitEnumStates;
  final EquipmentsEnumState locationEnumStates;
  final EquipmentsEnumState departmentEnumStates;

  final List<BusinessUnitModel> listBusinessUnit;
  final List<EquipmentsLocationModel> listLocation;
  final List<DepartmentsModel> listDepartment;
  final List<SelectedEquipmentsModel> chosenList;

  final String? statusAction;
  final String comment;
  final String actionComment;
  final RequestStatus? requestStatus;
  final RequestDate? requestDate;
  final EquipmentsRequestedModel? requestedData;
  final TakeActionStatus? takeActionStatus;

  final FormzStatus status;
  final EmployeeData requesterData;

  const EquipmentsCubitStates({
    this.businessUnitEnumStates = EquipmentsEnumState.initial,
    this.locationEnumStates = EquipmentsEnumState.initial,
    this.departmentEnumStates = EquipmentsEnumState.initial,
    this.status = FormzStatus.pure,
    this.requestStatus,
    this.statusAction,
    this.comment = '',
    this.actionComment = "",
    this.listBusinessUnit = const <BusinessUnitModel>[],
    this.listLocation = const <EquipmentsLocationModel>[],
    this.listDepartment = const <DepartmentsModel>[],
    this.chosenList = const <SelectedEquipmentsModel>[],
    this.requestDate,
    this.requestedData,
    this.takeActionStatus,
    this.requesterData = EmployeeData.empty,
  });

  EquipmentsCubitStates copyWith({
    EquipmentsEnumState? businessUnitEnumStates,
    EquipmentsEnumState? locationEnumStates,
    EquipmentsEnumState? departmentEnumStates,
    List<BusinessUnitModel>? listBusinessUnit,
    List<EquipmentsLocationModel>? listLocation,
    List<DepartmentsModel>? listDepartment,
    List<SelectedEquipmentsModel>? chosenList,
    String? statusAction,
    String? comment,
    RequestStatus? requestStatus,
    RequestDate? requestDate,
    EquipmentsRequestedModel? requestedData,
    TakeActionStatus? takeActionStatus,
    FormzStatus? status,
    EmployeeData? requesterData,
    String? actionComment,
  }) {
    return EquipmentsCubitStates(
      businessUnitEnumStates:
          businessUnitEnumStates ?? this.businessUnitEnumStates,
      locationEnumStates: locationEnumStates ?? this.locationEnumStates,
      departmentEnumStates: departmentEnumStates ?? this.departmentEnumStates,
      listBusinessUnit: listBusinessUnit ?? this.listBusinessUnit,
      listLocation: listLocation ?? this.listLocation,
      listDepartment: listDepartment ?? this.listDepartment,
      chosenList: chosenList ?? this.chosenList,
      requestStatus: requestStatus ?? this.requestStatus,
      requestDate: requestDate ?? this.requestDate,
      requestedData: requestedData ?? this.requestedData,
      status: status ?? this.status,
      statusAction: statusAction ?? this.statusAction,
      comment: comment ?? this.comment,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }

  @override
  List<Object> get props => [
        businessUnitEnumStates,
        locationEnumStates,
        departmentEnumStates,
        listBusinessUnit,
        listLocation,
        listDepartment,
        chosenList,
        comment,
        status,
        requesterData,
        actionComment,
      ];
}
