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
  final List<HistoryWorkFlowModel> historyWorkFlow;

  final FilePickerResult fileResult;

  final String? statusAction;
  final String extension;
  final String chosenFileName;
  final String comment;
  final String actionComment;
  final RequestStatus? requestStatus;
  final RequestDate? requestDate;
  final EquipmentsRequestedModel? requestedData;
  final TakeActionStatus? takeActionStatus;

  final FormzStatus status;
  final FormzStatus businessUnitStatus;
  final FormzStatus locationStatus;
  final FormzStatus departmentStatus;
  final EmployeeData requesterData;

  const EquipmentsCubitStates({
    this.fileResult = const FilePickerResult([]),
    this.businessUnitEnumStates = EquipmentsEnumState.initial,
    this.locationEnumStates = EquipmentsEnumState.initial,
    this.departmentEnumStates = EquipmentsEnumState.initial,
    this.status = FormzStatus.pure,
    this.businessUnitStatus = FormzStatus.pure,
    this.locationStatus = FormzStatus.pure,
    this.departmentStatus = FormzStatus.pure,
    this.requestStatus,
    this.statusAction,
    this.comment = '',
    this.actionComment = "",
    this.extension = "",
    this.chosenFileName = "",
    this.listBusinessUnit = const <BusinessUnitModel>[],
    this.listLocation = const <EquipmentsLocationModel>[],
    this.listDepartment = const <DepartmentsModel>[],
    this.chosenList = const <SelectedEquipmentsModel>[],
    this.historyWorkFlow = const <HistoryWorkFlowModel>[],
    this.requestDate,
    this.requestedData,
    this.takeActionStatus,
    this.requesterData = EmployeeData.empty,
  });

  EquipmentsCubitStates copyWith({
    FilePickerResult? fileResult,
    EquipmentsEnumState? businessUnitEnumStates,
    EquipmentsEnumState? locationEnumStates,
    EquipmentsEnumState? departmentEnumStates,
    List<BusinessUnitModel>? listBusinessUnit,
    List<EquipmentsLocationModel>? listLocation,
    List<DepartmentsModel>? listDepartment,
    List<HistoryWorkFlowModel>? historyWorkFlow,
    List<SelectedEquipmentsModel>? chosenList,
    String? statusAction,
    String? comment,
    String? extension,
    String? chosenFileName,
    RequestStatus? requestStatus,
    RequestDate? requestDate,
    EquipmentsRequestedModel? requestedData,
    TakeActionStatus? takeActionStatus,
    FormzStatus? status,
    FormzStatus? businessUnitStatus,
    FormzStatus? locationStatus,
    FormzStatus? departmentStatus,
    EmployeeData? requesterData,
    String? actionComment,
  }) {
    return EquipmentsCubitStates(
      fileResult: fileResult ?? this.fileResult,
      businessUnitEnumStates:
          businessUnitEnumStates ?? this.businessUnitEnumStates,
      locationEnumStates: locationEnumStates ?? this.locationEnumStates,
      departmentEnumStates: departmentEnumStates ?? this.departmentEnumStates,
      listBusinessUnit: listBusinessUnit ?? this.listBusinessUnit,
      listLocation: listLocation ?? this.listLocation,
      listDepartment: listDepartment ?? this.listDepartment,
      historyWorkFlow: historyWorkFlow ?? this.historyWorkFlow,
      chosenList: chosenList ?? this.chosenList,
      requestStatus: requestStatus ?? this.requestStatus,
      requestDate: requestDate ?? this.requestDate,
      requestedData: requestedData ?? this.requestedData,
      status: status ?? this.status,
      businessUnitStatus: businessUnitStatus ?? this.businessUnitStatus,
      locationStatus: locationStatus ?? this.locationStatus,
      departmentStatus: departmentStatus ?? this.departmentStatus,
      statusAction: statusAction ?? this.statusAction,
      comment: comment ?? this.comment,
      extension: extension ?? this.extension,
      chosenFileName: chosenFileName ?? this.chosenFileName,
      takeActionStatus: takeActionStatus ?? this.takeActionStatus,
      requesterData: requesterData ?? this.requesterData,
      actionComment: actionComment ?? this.actionComment,
    );
  }

  @override
  List<Object> get props => [
        fileResult,
        businessUnitEnumStates,
        locationEnumStates,
        departmentEnumStates,
        listBusinessUnit,
        listLocation,
        listDepartment,
        historyWorkFlow,
        chosenList,
        comment,
        extension,
        chosenFileName,
        status,
        businessUnitStatus,
        locationStatus,
        departmentStatus,
        requesterData,
        actionComment,
      ];
}
