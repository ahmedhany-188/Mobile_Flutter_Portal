import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/request_service_id.dart';
import 'package:heroicons/heroicons.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/enums.dart';
import '../../../../data/data_providers/general_dio/general_dio.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/departments_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/business_unit_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_location_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/equipments_requested_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/history_work_flow_model.dart';
import '../../../../data/models/it_requests_form_models/equipments_models/selected_equipments_model.dart';
import '../../../../data/models/requests_form_models/request_date.dart';
import '../../../../data/models/requests_form_models/request_response.dart';
import '../../../../data/repositories/employee_repository.dart';
import '../../../../data/repositories/request_repository.dart';

part 'equipments_state.dart';

class EquipmentsCubit extends Cubit<EquipmentsCubitStates> {
  EquipmentsCubit(this._requestRepository)
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
  final RequestRepository _requestRepository;

  void commentChanged(String value) {
    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        comment: value,
      ),
    );
  }

  void commentRequesterChanged(String value) {
    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        actionComment: value,
        // status: Formz.validate([state.requestDate,state.permissionDate,state.permissionTime]),
      ),
    );
  }

  void getRequestData(
      {required RequestStatus requestStatus,
      String? requestNo,
      String? requesterHRCode,
      String? date}) async {
    if (requestStatus == RequestStatus.newRequest) {
      var now = DateTime.now();
      String formattedDate = GlobalConstants.dateFormatViewed.format(now);

      if (date != null) {
        formattedDate =
            GlobalConstants.dateFormatViewed.format(DateTime.parse(date));
      } else {
        formattedDate = GlobalConstants.dateFormatViewed.format(now);
      }

      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
          requestDate: requestDate,
          requestStatus: RequestStatus.newRequest,
        ),
      );
    } else {
      EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
      final requestData = await _requestRepository.getEquipmentData(
          requestNo ?? '', requesterHRCode ?? '');

      // ContactsDataFromApi responsiblePerson;
      // if(requestData.ownerName != null){
      //   responsiblePerson =  ContactsDataFromApi(
      //       email: requestData.ownerName!.contains("null")
      //           ? "No Data"
      //           : requestData.ownerName,
      //       name: requestData.ownerName!.contains("null") ||
      //           requestData.ownerName!.isEmpty ? "No Data" : requestData
      //           .ownerName);
      // }else{
      //   responsiblePerson = const ContactsDataFromApi(
      //       email:  "No Data",
      //       name:  "No Data");
      // }

      // final requestDate = RequestDate.dirty(
      //     GlobalConstants.dateFormatViewed.format(
      //         GlobalConstants.dateFormatServer.parse(requestData.date!)));

      var status = "Pending";
      if (requestData.data![0].status == 0) {
        status = "Pending";
      } else if (requestData.data![0].status == 1) {
        status = "Approved";
      } else if (requestData.data![0].status == 2) {
        status = "Rejected";
      }

      final requesterData = await GetEmployeeRepository()
          .getEmployeeData(requestData.data![0].requestHRCode ?? "");

      getHistory(serviceId: RequestServiceID.equipmentServiceID, requestNumber: int.parse(requestNo.toString()));

      emit(
        state.copyWith(
            requestedData: requestData,
            requesterData: requesterData,
            // requestDate: requestDate,
            // vacationType: int.parse(requestData.vacationType ?? "1"),
            // responsiblePerson: responsiblePerson,
            // comment: comments,
            status: FormzStatus.valid,
            requestStatus: RequestStatus.oldRequest,
            statusAction: status,
            takeActionStatus: (_requestRepository.userData?.user?.userHRCode ==
                    requestData.data?[0].requestHRCode)
                ? TakeActionStatus.view
                : TakeActionStatus.takeAction),
      );
      EasyLoading.dismiss();
    }
  }

  Widget getIconByGroupName(String groupName) {
    switch (groupName) {
      case 'Accessories':
        return const Icon(Icons.keyboard_alt_outlined);
      case 'Laptop':
        return const Icon(Icons.laptop_chromebook_outlined);
      case 'Datashow / projector':
        return const Icon(Icons.live_tv);
      case 'Desktop':
        return const Icon(Icons.computer_outlined);
      case 'Toner/Ink':
        return const Icon(Icons.water_drop);
      case 'Network':
        return const HeroIcon(HeroIcons.globeAlt);
      case 'Server':
        return const HeroIcon(HeroIcons.server);
      case 'Printer':
        return const Icon(Icons.print_outlined);
      case 'Telephones':
        return const Icon(Icons.call);
      case 'Internet connection':
        return const Icon(Icons.network_wifi_outlined);
      case 'Fingerprint':
        return const Icon(Icons.fingerprint);
    }
    return const Icon(Icons.access_alarm_outlined);
  }

  String? getRequestForFromType(int? type) {
    switch (type) {
      case 1:
        return 'New Hire';
      case 2:
        return 'Replacement / New Item';
      case 3:
        return 'Training';
      case 4:
        return 'Mobilization';
    }
    return null;
  }

  void validateForm({
    FormzStatus? businessUnit,
    FormzStatus? location,
    FormzStatus? department,
  }) {
    emit(state.copyWith(
      businessUnitStatus: businessUnit,
      locationStatus: location,
      departmentStatus: department,
    ));
  }

  submitAction(ActionValueStatus valueStatus, String requestNo) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    final equipmentResultResponse = await _requestRepository
        .postEquipmentTakeActionRequest(
      valueStatus: valueStatus,
      requestNo: requestNo,
      actionComment: state.actionComment,
      serviceID: RequestServiceID.equipmentServiceID,
      requesterHRCode: state.requesterData.userHrCode ?? "",
      requesterEmail: state.requesterData.email ?? "",
      serviceName: GlobalConstants.requestCategoryEquipment,
    )
        .catchError((err) {
      EasyLoading.showError('Something went wrong');
      throw err;
    });

    final result = equipmentResultResponse.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      emit(
        state.copyWith(
          // successMessage: "#$requestNo \n ${valueStatus == ActionValueStatus.accept ? "Request has been Accepted":"Request has been Rejected"}",
          status: FormzStatus.submissionSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          // errorMessage:"An error occurred",
          status: FormzStatus.submissionFailure,
        ),
      );
      // }
    }
  }

  void postEquipmentsRequest({
    required DepartmentsModel departmentObject,
    required BusinessUnitModel businessUnitObject,
    required EquipmentsLocationModel locationObject,
    required String userHrCode,
    required List<SelectedEquipmentsModel> selectedItem,
    String? comment,
  }) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    RequestResponse equipmentResponse = await _requestRepository.postEquipmentRequest(comment: comment,departmentObject: departmentObject, businessUnitObject: businessUnitObject, locationObject: locationObject, userHrCode: userHrCode, selectedItem: selectedItem, fileResult: state.fileResult, extension: state.extension);
    if (equipmentResponse.id == 1){
      emit(
        state.copyWith(
          successMessage: equipmentResponse.requestNo,
          status: FormzStatus.submissionSuccess,
        ),
      );
    }else{
      emit(
        state.copyWith(
          errorMessage: equipmentResponse.id == 0 ? equipmentResponse.result : "An error occurred",
          status: FormzStatus.submissionFailure,
        ),
      );
    }


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
      throw 'chosen list exception';
    } else {
      emit(state.copyWith(
        chosenList: [...state.chosenList, chosenObject],
      ));
    }
  }

  void uploadEquipmentRequestFile() {}
  void setChosenFileName() async {
    String extension = '';
    String chosenFileName = '';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      extension = result.files.first.extension!;
      chosenFileName = result.files.first.name;
    }
    emit(state.copyWith(
        extension: extension,
        fileResult: result,
        chosenFileName: chosenFileName));
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

  void getHistory({required String serviceId, required int requestNumber}) {
    GeneralDio.getHistoryWorkFlow(serviceId: serviceId, reqNo: requestNumber)
        .then((value) {
      List<HistoryWorkFlowModel> history;
      history = List<HistoryWorkFlowModel>.from(
          value.data.map((model) => HistoryWorkFlowModel.fromJson(model)));

      emit(state.copyWith(
          historyWorkFlow: history
            ..sort((a, b) => a.createdate!.compareTo(b.createdate!))));
    });
  }
}
