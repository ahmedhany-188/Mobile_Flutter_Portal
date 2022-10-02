import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/data_providers/medical_request_data_provider/medical_request_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:hassanallamportalflutter/data/repositories/medical_request_repository.dart';
import 'package:intl/intl.dart';

import '../../widgets/dialogpopoup/custom_date_picker.dart';
part 'medical_request_state.dart';

class MedicalRequestCubit extends Cubit<MedicalRequestInitial> {
  MedicalRequestCubit() : super(const MedicalRequestInitial());

  final Connectivity connectivity = Connectivity();

  static MedicalRequestCubit get(context) => BlocProvider.of(context);

  void getSuccessMessage(String hrCode) async {

    final patientNameMedicalRequest = RequestDate.dirty(
        state.patientNameMedicalRequest.value);
    final selectedValueLab = RequestDate.dirty(state.selectedValueLab.value);
    final selectedValueService = RequestDate.dirty(
        state.selectedValueService.value);

    final requestDate = RequestDate.dirty(state.requestDate.value);





    emit(state.copyWith(
      patientNameMedicalRequest: patientNameMedicalRequest,
      selectedValueLab: selectedValueLab,
      selectedValueService: selectedValueService,
      requestDate: requestDate,
      status: Formz.validate([
        patientNameMedicalRequest,
        selectedValueLab,
        selectedValueService,
        requestDate
      ]),
    ));

    if (state.status.isValidated) {
      String selectedLab = "",
          selectedService = "";
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      switch (selectedValueLab.value.toString()) {
        case "ELmokhtaber":
          selectedLab = "0";
          selectedService = "0";
          break;
        case "ELBORG":
          selectedLab = "1";
          break;
      }

      switch (selectedValueService.value.toString()) {
        case "Lab":
          selectedService = "0";
          break;
        case "Scan":
          selectedService = "1";
          break;
      }
      DateTime requestDateTemp = GlobalConstants.dateFormatViewed.parse(requestDate.value);
      final requestDateValue = GlobalConstants.dateFormatServer.format(requestDateTemp);

      RequestMedicalBenefit requestMedicalBenefit = RequestMedicalBenefit(
          hrCode, patientNameMedicalRequest.value.toString(),
          requestDateValue, selectedLab, selectedService);

      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          MedicalRepository().getMedicalData(requestMedicalBenefit)
          // MedicalRequestDataProvider(requestMedicalBenefit)
          //     .getMedicalRequestMessage()
              .then((value) {
            emit(
              state.copyWith(
                successMessage: value.body.toString(),
                status: FormzStatus.submissionSuccess,
              ),
            );
          }).catchError((error) {
            emit(
              state.copyWith(
                errorMessage: error.toString(),
                status: FormzStatus.submissionFailure,
              ),
            );
          });
        } else {
          emit(
            state.copyWith(
              errorMessage: "No internet Connection",
              status: FormzStatus.submissionFailure,
            ),
          );
          // emit(BlocgetTheMedicalRequestErrorState("No internet Connection"));
        }
      }
      catch (e) {
        // emit(BlocgetTheMedicalRequestErrorState(e.toString()));
        emit(
          state.copyWith(
            errorMessage: e.toString(),
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }

  void patientName(String value) {
    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    final patientName = RequestDate.dirty(value);
    emit(
      state.copyWith(
        patientNameMedicalRequest: patientName,
        status: Formz.validate([
          patientName,
          state.selectedValueLab,
          state.selectedValueService,
          state.requestDate
        ]),
      ),
    );
  }

  // set the new date
  void selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(
        FocusNode());

    DateTime? currentDate = DateTime.now();


    currentDate = await openShowDatePicker(context);

    var formatter = GlobalConstants.dateFormatViewed;
    String formattedDate = formatter.format(
        currentDate ?? DateTime.now());
    final requestDate = RequestDate.dirty(formattedDate);

    emit(
      state.copyWith(
        requestDate: requestDate,
        status: Formz.validate([
          state.patientNameMedicalRequest,
          state.selectedValueLab,
          state.selectedValueService,
          requestDate
        ]),
      ),
    );
  }

  void addSelectedLab(String lab1) {
    final lab = RequestDate.dirty(lab1);
    emit(
      state.copyWith(
        selectedValueLab: lab,
        status: Formz.validate([
          state.patientNameMedicalRequest,
          lab,
          state.selectedValueService,
          state.requestDate
        ]),
      ),
    );
  }

  void addSelectedService(String service1) {
    final service = RequestDate.dirty(service1);
    emit(
      state.copyWith(
        selectedValueService: service,
        status: Formz.validate([
          state.patientNameMedicalRequest,
          state.selectedValueLab,
          service,
          state.requestDate
        ]),
      ),
    );
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    EasyLoading.dismiss();

    return super.close();
  }

}
