import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/contacts_related_models/contacts_data_from_api.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_type.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_from.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';

import '../../../constants/enums.dart';
import '../../../data/models/requests_form_models/request_date.dart';
import '../../../data/models/requests_form_models/request_permission_time.dart';

part 'vacation_state.dart';

class VacationCubit extends Cubit<VacationInitial> {
  VacationCubit(this._requestRepository) : super(const VacationInitial());
  // LoginCubit(this._authenticationRepository) : super(const LoginState());

  final RequestRepository _requestRepository;


  void getRequestData(RequestStatus requestStatus) {
    if (requestStatus == RequestStatus.newRequest){
      var now = DateTime.now();
      var formatter = DateFormat('EEEE dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
          requestDate: requestDate,
          status: Formz.validate([requestDate,
              state.vacationFromDate,state.vacationToDate]),
          requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
      final requestDate = RequestDate.dirty("requestDate");
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([requestDate,
               state.vacationFromDate,state.vacationToDate]),
            requestStatus: RequestStatus.oldRequest
        ),
      );
    }
  }

  void vacationFromDateChanged(BuildContext context) async{
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(
        FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    var formatter = DateFormat(
        'EEEE dd-MM-yyyy');
    String formattedDate = formatter.format(
        date ?? DateTime.now());
    final vacationFromDate = DateFrom.dirty(formattedDate);
    final vacationToDate = DateTo.dirty(
      dateFrom: vacationFromDate.value,
      value: state.vacationToDate.value,
    );

    emit(
      state.copyWith(
        vacationFromDate: vacationFromDate,
        vacationToDate: vacationToDate,
        status: Formz.validate([state.requestDate,vacationFromDate,vacationToDate]),
      ),
    );
    await getVacationDuration();
  }
  void vacationToDateChanged(BuildContext context) async {
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(
        FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    var formatter = DateFormat(
        'EEEE dd-MM-yyyy');
    String formattedDate = formatter.format(
        date ?? DateTime.now());
    final vacationToDate = DateTo.dirty(dateFrom: state.vacationFromDate.value,value: formattedDate);
    emit(
      state.copyWith(
        vacationToDate: vacationToDate,
        status: Formz.validate([state.requestDate,state.vacationFromDate,vacationToDate]),
      ),
    );
    await getVacationDuration();
  }
  void vacationTypeChanged(int value) {
    final vacationType = value;
    emit(
      state.copyWith(
        vacationType: vacationType,
        status: Formz.validate([state.requestDate,state.vacationFromDate,state.vacationToDate]),
      ),
    );
  }
  void vacationResponsiblePersonChanged(ContactsDataFromApi value) {
    final responsiblePerson = value;
    emit(
      state.copyWith(
        responsiblePerson: responsiblePerson,
        status: Formz.validate([state.requestDate,state.vacationFromDate,state.vacationToDate]),
      ),
    );
  }
  // void permissionTimeChanged(String value) {
  //
  //   final permissionTime = PermissionTime.dirty(value);
  //   print(permissionTime.value);
  //   emit(
  //     state.copyWith(
  //       permissionTime: permissionTime,
  //       status: Formz.validate([state.requestDate,state.vacationFromDate,state.vacationToDate,permissionTime]),
  //     ),
  //   );
  // }
  void commentChanged(String value) {

    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        comment: value,
        status: Formz.validate([state.requestDate,state.vacationFromDate,state.vacationToDate]),
      ),
    );
  }

  Future<void> getVacationDuration()async {
    if(state.vacationFromDate.valid && state.vacationToDate.valid){
      final dateFromString = state.vacationFromDate.value;
      final dateToString = state.vacationToDate.value;
      final dateFrom = DateFormat("EEEE dd-MM-yyyy").parse(dateFromString);
      final dateTo = DateFormat("EEEE dd-MM-yyyy").parse(dateToString);
      var formatter = DateFormat('MM/dd/yyyy');
      //
      String formattedFromDate = formatter.format(dateFrom);
      String formattedToDate = formatter.format(dateTo);

      final durationResponse = await _requestRepository.getDurationVacation(state.vacationType, formattedFromDate, formattedToDate);
      if(durationResponse.result != null){
        print(durationResponse.result![0].result);
        emit(
          state.copyWith(
            vacationDuration: durationResponse.result![0].result,
            status: Formz.validate([state.requestDate,state.vacationFromDate,state.vacationToDate]),
          ),
        );
      }


    }else{
      return;
    }






  }

  Future<void> submitVacationRequest(String hrCode) async {
    print("submit permission");
    final requestDate = RequestDate.dirty(state.requestDate.value);
    final vacationFromDate = DateFrom.dirty(state.vacationFromDate.value);
    final vacationToDate = DateTo.dirty(value: state.vacationToDate.value,dateFrom:state.vacationFromDate.value );
    emit(state.copyWith(
      requestDate: requestDate,
      vacationFromDate: vacationFromDate,
      vacationToDate: vacationToDate,
      status: Formz.validate([requestDate, vacationFromDate,vacationToDate]),
    ));
    if (state.status.isValidated) {
      // print("Done permission");
      final DateFormat dateFormatViewed = DateFormat("EEEE dd-MM-yyyy");
      final DateFormat dateFormatServer = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      // "date" -> "2022-05-17T13:47:07"
      DateTime requestDateTemp = dateFormatViewed.parse(requestDate.value);
      final requestDateValue = dateFormatServer.format(requestDateTemp);
      print("requestDateValue $requestDateValue");

      // "date" -> "2022-05-17T13:47:07"
      DateTime dateFromTemp = dateFormatViewed.parse(vacationFromDate.value);
      final dateFromValue = dateFormatServer.format(dateFromTemp);
      print("dateFromValue $dateFromValue");

      // "dateTo" -> "2022-05-17T13:47:07"
      DateTime dateToTemp = dateFormatViewed.parse(vacationToDate.value);
      final dateToValue = dateFormatServer.format(dateToTemp);
      print("dateToValue $dateToValue");

      String responsibleHRCode = state.responsiblePerson.userHrCode ?? "";

      int noOfDays = int.parse(state.vacationDuration);



      // "permissionDate" -> "2022-05-17T00:00:00"
      // DateTime permissionDateTemp = DateFormat("EEEE dd-MM-yyyy").parse(permissionDate.value);
      // final permissionDateValue = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(permissionDateTemp);
      // print("permissionDateValue $permissionDateValue");
      // "comments" -> "Aaaaa"
      final comment = state.comment;
      print("comment $comment");


      final type = "${state.vacationType}";
      print("type $type");

      print(hrCode);

      final vacationResponse = await _requestRepository.postVacationRequest(hrCode: hrCode,comments: comment,
          dateFrom: dateFromValue,dateTo: dateToValue,requestDate: requestDateValue,type: type, responsibleHRCode: responsibleHRCode, noOfDays: noOfDays);


      if (vacationResponse.id == 1){
        // print(permissionResponse.requestNo);
        emit(
          state.copyWith(
            successMessage: vacationResponse.requestNo,
            status: FormzStatus.submissionSuccess,
          ),
        );
      }else{
        // if (vacationResponse.id == 0) {
          // print(permissionResponse.requestNo);
          emit(
            state.copyWith(
              errorMessage: vacationResponse.id == 0 ? vacationResponse.result : "An error occurred",
              status: FormzStatus.submissionFailure,
            ),
          );
        // }
      }
    }
  }
}
