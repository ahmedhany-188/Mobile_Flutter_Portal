import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/request_service_id.dart';

import '../../../../constants/enums.dart';
import '../../../../data/data_providers/general_dio/general_dio.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/departments_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/business_unit_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/selected_equipments_model.dart';
import '../../../../data/repositories/request_repository.dart';

part 'equipments_state.dart';

class EquipmentsCubit extends Cubit<EquipmentsCubitStates> {
  EquipmentsCubit(this.requestRepository)
      : super(const EquipmentsCubitStates()) {
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
  final RequestRepository requestRepository;

  void getEquipmentsData(RequestStatus requestStatus, String? requestNo) async {
    final requestData = await requestRepository.getEquipments(requestNo!);

    var status = "Pending";
    if (requestData.status == 0) {
      status = "Pending";
    } else if (requestData.status == 1) {
      status = "Approved";
    } else if (requestData.status == 2) {
      status = "Rejected";
    }

    emit(
      state.copyWith(
        requestStatus: RequestStatus.oldRequest,
        statusAction: status,
        // takeActionStatus: (requestRepository.userData.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction
      ),
    );
  }

  void postEquipmentsRequest({
    required DepartmentsModel departmentObject,
    required BusinessUnitModel businessUnitObject,
    required EquipmentsLocationModel locationObject,
    required String userHrCode,
    required List<SelectedEquipmentsModel> selectedItem,
  }) {
    var masterDataPost = {
      "requestNo": 0,
      "serviceId": RequestServiceID.equipmentServiceID,
      "departmentId": businessUnitObject.departmentId,
      "projectId": '',
      "locationId": locationObject.projectId.toString(),
      "requestHrCode": userHrCode,
      "date": DateTime.now().toString(),
      "comments": "",
      "newComer": true,
      "approvalPathId": 0,
      "status": 0,
      "nplusEmail": "",
      "closedDate": DateTime.now().toString(),
      "reRequestCode": 0
    };
    GeneralDio.postMasterEquipmentsRequest(masterDataPost).then((value) {
      for (int i = 0; i < selectedItem.length; i++) {
        int type = 1;
        switch (selectedItem[i].requestFor) {
          case 'New Hire':
            type = 1;
            break;
          case 'Replacement / New Item':
            type = 2;
            break;
          case 'Training':
            type = 3;
            break;
          case 'Mobilization':
            type = 4;
            break;
        }
        Map<String, dynamic> detailedDataPost = {
          "requestNo": int.parse(value.data['requestNo']),
          "hardWareItemId":
              selectedItem[i].selectedItem!.hardWareItemId.toString(),
          "ownerHrCode": selectedItem[i].selectedContact!.userHrCode.toString(),
          "type": type,
          "qty": selectedItem[i].quantity,
          "chk": true,
          "estimatePrice": 0,
          "approved": true,
          "rejectedHrCode": ""
        };
        GeneralDio.postDetailEquipmentsRequest(detailedDataPost)
            .catchError((e) {
          throw e;
        });
      }
    }).catchError((e) {
      throw e;
    });
  }

  void setChosenList({
    required SelectedEquipmentsModel chosenObject,
  }) {
    if (state.chosenList.isEmpty) {
      emit(state.copyWith(
        chosenList: [...state.chosenList, chosenObject],
      ));
    } else if (state.chosenList.any((element) =>
        element.selectedItem?.hardWareItemName ==
        chosenObject.selectedItem?.hardWareItemName)) {
      throw 'ew3a';
    } else {
      emit(state.copyWith(
        chosenList: [...state.chosenList, chosenObject],
      ));
    }
  }

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
