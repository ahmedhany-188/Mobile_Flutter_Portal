part of 'equipments_cubit.dart';

enum EquipmentsEnumState { initial, success, failed }

class EquipmentsCubitStates extends Equatable {
  final EquipmentsEnumState businessUnitEnumStates;
  final EquipmentsEnumState locationEnumStates;
  final EquipmentsEnumState departmentEnumStates;
  // final EquipmentsEnumState chosenListEnumStates;
  final List<BusinessUnitModel> listBusinessUnit;
  final List<EquipmentsLocationModel> listLocation;
  final List<DepartmentsModel> listDepartment;
  final List<SelectedEquipmentsModel> chosenList;


  const EquipmentsCubitStates({
    this.businessUnitEnumStates = EquipmentsEnumState.initial,
    this.locationEnumStates = EquipmentsEnumState.initial,
    this.departmentEnumStates = EquipmentsEnumState.initial,
    // this.chosenListEnumStates = EquipmentsEnumState.initial,
    this.listBusinessUnit = const <BusinessUnitModel>[],
    this.listLocation = const <EquipmentsLocationModel>[],
    this.listDepartment = const <DepartmentsModel>[],
    this.chosenList = const <SelectedEquipmentsModel>[],
  });

  EquipmentsCubitStates copyWith({
    EquipmentsEnumState? businessUnitEnumStates,
    EquipmentsEnumState? locationEnumStates,
    EquipmentsEnumState? departmentEnumStates,
    // EquipmentsEnumState? chosenListEnumStates,
    List<BusinessUnitModel>? listBusinessUnit,
    List<EquipmentsLocationModel>? listLocation,
    List<DepartmentsModel>? listDepartment,
    List<SelectedEquipmentsModel>? chosenList,
  }) {
    return EquipmentsCubitStates(
        businessUnitEnumStates:
            businessUnitEnumStates ?? this.businessUnitEnumStates,
        locationEnumStates: locationEnumStates ?? this.locationEnumStates,
        departmentEnumStates: departmentEnumStates ?? this.departmentEnumStates,
        // chosenListEnumStates: chosenListEnumStates ?? this.chosenListEnumStates,
        listBusinessUnit: listBusinessUnit ?? this.listBusinessUnit,
        listLocation: listLocation ?? this.listLocation,
        listDepartment: listDepartment ?? this.listDepartment,
        chosenList: chosenList ?? this.chosenList);
  }

  @override
  List<Object> get props => [
        businessUnitEnumStates,
        locationEnumStates,
        departmentEnumStates,
        // chosenListEnumStates,
        listBusinessUnit,
        listLocation,
        listDepartment,
        chosenList,
      ];
}
