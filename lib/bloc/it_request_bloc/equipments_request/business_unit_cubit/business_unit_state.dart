part of 'business_unit_cubit.dart';

abstract class BusinessUnitState extends Equatable {}

enum EquipmentsEnumState { initial, success, failed }

class EquipmentsCubitStates extends Equatable {
  final EquipmentsEnumState businessUnitEnumStates;
  final EquipmentsEnumState locationEnumStates;
  final EquipmentsEnumState departmentEnumStates;
  final List<BusinessUnitModel> listBusinessUnit;
  final List<EquipmentsLocationModel> listLocation;
  final List<DepartmentsModel> listDepartment;
  const EquipmentsCubitStates({
    this.businessUnitEnumStates = EquipmentsEnumState.initial,
    this.locationEnumStates = EquipmentsEnumState.initial,
    this.departmentEnumStates = EquipmentsEnumState.initial,
    this.listBusinessUnit = const <BusinessUnitModel>[],
    this.listLocation = const <EquipmentsLocationModel>[],
    this.listDepartment = const <DepartmentsModel>[],
  });

  EquipmentsCubitStates copyWith({
    EquipmentsEnumState? businessUnitEnumStates,
    EquipmentsEnumState? locationEnumStates,
    EquipmentsEnumState? departmentEnumStates,
    List<BusinessUnitModel>? listBusinessUnit,
    List<EquipmentsLocationModel>? listLocation,
    List<DepartmentsModel>? listDepartment,
  }) {
    return EquipmentsCubitStates(
      businessUnitEnumStates:
          businessUnitEnumStates ?? this.businessUnitEnumStates,
      locationEnumStates: locationEnumStates ?? this.locationEnumStates,
      departmentEnumStates: departmentEnumStates ?? this.departmentEnumStates,
      listBusinessUnit: listBusinessUnit ?? this.listBusinessUnit,
      listLocation: listLocation ?? this.listLocation,
      listDepartment: listDepartment ?? this.listDepartment,
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
      ];
}
