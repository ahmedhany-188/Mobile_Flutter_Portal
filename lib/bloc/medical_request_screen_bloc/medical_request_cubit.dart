import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/data_providers/medical_request_data_provider/medical_request_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_medical_benefit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'medical_request_state.dart';

class MedicalRequestCubit extends Cubit<MedicalRequestInitial> {
  MedicalRequestCubit() : super(MedicalRequestInitial());

  final Connectivity connectivity = Connectivity();

  static MedicalRequestCubit get(context) => BlocProvider.of(context);

  void getSuccessMessage(String hrCode) async {



    final patientname_MedicalRequest = RequestDate.dirty(state.patientnameMedicalRequest.value);
    final selectedValueLab = RequestDate.dirty(state.selectedValueLab.value);
    final selectedValueService =  RequestDate.dirty(state.selectedValueService.value);
    final requestDate = RequestDate.dirty(state.requestDate.value);

    emit(state.copyWith(
      patientnameMedicalRequest:patientname_MedicalRequest,
      selectedValueLab:selectedValueLab,
      selectedValueService:selectedValueService,
      requestDate: requestDate,
      status: Formz.validate( [patientname_MedicalRequest,selectedValueLab,selectedValueService,requestDate]),
    ));

    if (state.status.isValidated) {

      String selectedLab="",selectedService="";
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      // emit(BlocGetTheMedicalRequestLoadingState());

      print("--------"+selectedValueLab.value.toString());
      print("-,,----"+selectedValueService.value.toString());

      switch(selectedValueLab.value.toString()){
        case "ELmokhtaber":
          selectedLab="0";
          break;
        case "ELBORG":
          selectedLab="1";
          break;
      }

      switch(selectedValueService.value.toString()){
        case "Lab":
          selectedService="0";
          break;
        case "Scan":
          selectedService="1";
          break;
      }

      print("----------="+selectedLab);
      print("----------="+selectedService);

      RequestMedicalBenefit  requestMedicalBenefit=new RequestMedicalBenefit(hrCode, patientname_MedicalRequest.value.toString(),
          requestDate.value.toString()+"T08:27:57.220Z", selectedLab, selectedService);

      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {

          MedicalRequestDataProvider(requestMedicalBenefit).getMedicalRequestMessage().then((value) {
            // emit(BlocgetTheMedicalRequestSuccesState("Success"));

            print(value.body.toString());
            emit(
              state.copyWith(
                successMessage: value.body.toString(),
                status: FormzStatus.submissionSuccess,
              ),
            );

          }).catchError((error) {
            print(error.toString());
            // emit(BlocgetTheMedicalRequestErrorState(error.toString()));
            emit(
              state.copyWith(
                errorMessage: error.toString(),
                status: FormzStatus.submissionFailure,
              ),
            );
          });
        }else{
          emit(
            state.copyWith(
              errorMessage: "No internet Connection",
              status: FormzStatus.submissionFailure,
            ),
          );
          // emit(BlocgetTheMedicalRequestErrorState("No internet Connection"));
        }
      }
      catch(e){
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
        patientnameMedicalRequest: patientName,
        status: Formz.validate([patientName,state.selectedValueLab,state.selectedValueService,state.requestDate]),
      ),
    );

  }

  // set the new date
 void selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(
        FocusNode());

    DateTime? currentDate = DateTime.now();


    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS) {

      await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.25,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  currentDate = value;
                },
                initialDateTime: DateTime.now(),
                minimumYear: 2020,
                maximumYear: 2023,
              ),
            );
          });

    }else{

      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));

      if (picked != null && picked != currentDate) {
        currentDate = picked;
      }
    }

    // var formatter = DateFormat('EEEE dd-MM-yyyy');
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(
        currentDate ?? DateTime.now());
    final requestDate = RequestDate.dirty(formattedDate);

    emit(
        state.copyWith(
          requestDate: requestDate,
          status: Formz.validate([state.patientnameMedicalRequest,state.selectedValueLab,state.selectedValueService,requestDate]),
        ),
    );

  }

  void addSelectedLab(String lab1){
    final lab = RequestDate.dirty(lab1);
    emit(
      state.copyWith(
        selectedValueLab: lab,
        status: Formz.validate([state.patientnameMedicalRequest,lab,state.selectedValueService,state.requestDate]),
      ),
    );
  }

  void addSelectedService(String service1){
    final service = RequestDate.dirty(service1);
    emit(
      state.copyWith(
        selectedValueService: service,
        status: Formz.validate([state.patientnameMedicalRequest,state.selectedValueLab,service,state.requestDate]),
      ),
    );
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
