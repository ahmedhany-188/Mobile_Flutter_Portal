import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_providers/general_dio/general_dio.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/business_unit_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/departments_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/selected_equipments_model.dart';

part 'equipments_state.dart';

class EquipmentsCubit extends Cubit<EquipmentsCubitStates> {
  EquipmentsCubit() : super(const EquipmentsCubitStates()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.businessUnitEnumStates == EquipmentsEnumState.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getAll();
          } catch (e) {
            emit(state.copyWith(
              businessUnitEnumStates: EquipmentsEnumState.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            businessUnitEnumStates: EquipmentsEnumState.failed,
          ));
        }
      }
    });
  }
  static EquipmentsCubit get(context) => BlocProvider.of(context);

  final Connectivity connectivity = Connectivity();

  void getAll() {
    getBusinessUnit();
    getLocation();
    getDepartment();
  }

  void getBusinessUnit() {
    emit(state.copyWith(
      businessUnitEnumStates: EquipmentsEnumState.initial,
    ));
    GeneralDio.businessUnit().then((value) {
      List<BusinessUnitModel> businessUnit;
      businessUnit = List<BusinessUnitModel>.from(
          value.data.map((model) => BusinessUnitModel.fromJson(model)));

      emit(state.copyWith(
          businessUnitEnumStates: EquipmentsEnumState.success,
          listBusinessUnit: businessUnit));
    }).catchError((err) {
      emit(state.copyWith(businessUnitEnumStates: EquipmentsEnumState.failed));
    });
  }

  void getLocation() {
    emit(state.copyWith(
      locationEnumStates: EquipmentsEnumState.initial,
    ));
    GeneralDio.equipmentsLocation().then((value) {
      List<EquipmentsLocationModel> location;
      location = List<EquipmentsLocationModel>.from(
          value.data.map((model) => EquipmentsLocationModel.fromJson(model)));

      emit(state.copyWith(
          locationEnumStates: EquipmentsEnumState.success,
          listLocation: location));
    }).catchError((err) {
      emit(state.copyWith(locationEnumStates: EquipmentsEnumState.failed));
    });
  }

  void getDepartment() {
    emit(state.copyWith(
      departmentEnumStates: EquipmentsEnumState.initial,
    ));
    GeneralDio.equipmentsDepartment().then((value) {
      List<DepartmentsModel> departments;
      departments = List<DepartmentsModel>.from(
          value.data.map((model) => DepartmentsModel.fromJson(model)));

      emit(state.copyWith(
          departmentEnumStates: EquipmentsEnumState.success,
          listDepartment: departments));
    }).catchError((err) {
      emit(state.copyWith(departmentEnumStates: EquipmentsEnumState.failed));
    });
  }
}
