import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:intl/intl.dart';

import '../../../constants/enums.dart';
import '../../../data/models/requests_form_models/request_date.dart';
import '../../../data/models/requests_form_models/request_date_from.dart';
import '../../../data/models/requests_form_models/request_time_from.dart';
import '../../../data/models/requests_form_models/request_time_to.dart';

part 'business_mission_state.dart';

class BusinessMissionCubit extends Cubit<BusinessMissionInitial> {
  BusinessMissionCubit(this._requestRepository) : super(const BusinessMissionInitial());
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
            state.timeFrom , state.dateFrom]),
          requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
      final requestDate = RequestDate.dirty("requestDate");
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([requestDate,
              state.timeFrom , state.dateFrom]),
            requestStatus: RequestStatus.oldRequest
        ),
      );
    }
  }

  void businessDateFromChanged(BuildContext context) async{
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
    final dateFrom = DateFrom.dirty(formattedDate);
    final dateTo = DateTo.dirty(
      dateFrom: dateFrom.value,
      value: state.dateTo.value,
    );
    // final businessDateFrom = DateFrom.dirty(value);
    emit(
      state.copyWith(
        dateFrom: dateFrom,
        dateTo: dateTo,
        status: Formz.validate([state.requestDate,dateFrom, state.timeFrom]),
      ),
    );
  }

  void businessToDateChanged(BuildContext context) async {
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
    final dateTo = DateTo.dirty(dateFrom: state.dateFrom.value,value: formattedDate);
    emit(
      state.copyWith(
        dateTo: dateTo,
        status: Formz.validate([state.requestDate,state.dateFrom,dateTo]),
      ),
    );
  }
  void missionTypeChanged(int value) {
    final missionType = value;
    emit(
      state.copyWith(
        missionType: missionType,
        status: Formz.validate([state.requestDate,state.dateFrom,state.timeFrom]),
      ),
    );
  }
  void businessTimeFromChanged(BuildContext context) async{
    TimeOfDay? time = TimeOfDay.now();
    final localizations = MaterialLocalizations
        .of(context);
    FocusScope.of(context).requestFocus(
        FocusNode());
    time =
        await showTimePicker(context: context,
        initialTime: TimeOfDay.now());
    // if (time != null){

    final formattedTimeOfDay = localizations
        .formatTimeOfDay(
        time ?? TimeOfDay.now());
    // permissionTimeController.text =
    //     formattedTimeOfDay;
    final timeFrom = TimeFrom.dirty(formattedTimeOfDay);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        timeFrom: timeFrom,
        status: Formz.validate([state.requestDate,state.dateFrom,timeFrom]),
      ),
    );
  }
  void businessTimeToChanged(BuildContext context) async{
    TimeOfDay? time = TimeOfDay.now();
    final localizations = MaterialLocalizations
        .of(context);
    FocusScope.of(context).requestFocus(
        FocusNode());
    time =
    await showTimePicker(context: context,
        initialTime: TimeOfDay.now());
    final formattedTimeOfDay = localizations
        .formatTimeOfDay(
        time ?? TimeOfDay.now());
    final timeTo = TimeTo.dirty(formattedTimeOfDay);
    emit(
      state.copyWith(
        timeTo: timeTo,
        status: Formz.validate([state.requestDate,state.dateFrom,state.timeFrom,timeTo]),
      ),
    );
  }
  void commentChanged(String value) {

    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        comment: value,
        status: Formz.validate([state.requestDate,state.dateFrom,state.timeFrom]),
      ),
    );
  }

  Future<void> submitBusinessMissionRequest(String hrCode) async {
    print("submit permission");
    final requestDate = RequestDate.dirty(state.requestDate.value);
    final dateFrom = DateFrom.dirty(state.dateFrom.value);
    final dateTo = DateTo.dirty(value: state.dateTo.value,dateFrom: dateFrom.value);
    final timeFrom = TimeFrom.dirty(state.timeFrom.value);
    final timeTo = TimeTo.dirty(state.timeTo.value);
    emit(state.copyWith(
      requestDate: requestDate,
      dateFrom: dateFrom,
      dateTo: dateTo,
      timeTo: timeTo,
      timeFrom: timeFrom,
      status: Formz.validate([requestDate, dateFrom,dateTo,timeFrom,timeTo]),
    ));
    if (state.status.isValidated) {
      // print("Done permission");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final DateFormat dateFormatViewed = DateFormat("EEEE dd-MM-yyyy");
      final DateFormat dateFormatServer = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      // "date" -> "2022-05-17T13:47:07"
      DateTime requestDateTemp = dateFormatViewed.parse(requestDate.value);
      final requestDateValue = dateFormatServer.format(requestDateTemp);
      print("requestDateValue $requestDateValue");

      // "permissionDate" -> "2022-05-17T00:00:00"
      DateTime dateFromTemp = dateFormatViewed.parse(dateFrom.value);
      final dateFromValue = dateFormatServer.format(dateFromTemp);
      print("dateFromValue $dateFromValue");

      DateTime dateToTemp = dateFormatViewed.parse(dateTo.value);
      final dateToValue = dateFormatServer.format(dateToTemp);
      print("dateToValue $dateToValue");
      // "comments" -> "Aaaaa"
      final comment = state.comment;
      print("comment $comment");


      DateTime hourFromTemp= DateFormat("hh:mm a").parse(timeFrom.value);
      final hourFromValue = DateFormat("hh").format(hourFromTemp);
      print("hourFrom $hourFromValue");
      final dateFromAmpm = DateFormat("a").format(hourFromTemp);
      print("dateFromAmpm $dateFromAmpm");

      DateTime hourToTemp= DateFormat("hh:mm a").parse(timeTo.value);
      final hourToValue = DateFormat("hh").format(hourToTemp);
      print("hourToValue $hourToValue");
      final dateToAmpm = DateFormat("a").format(hourToTemp);
      print("dateToAmpm $dateToAmpm");


      final type = "${state.missionType}";
      print("type $type");

      print(hrCode);


      final businessMissionResponse = await _requestRepository.postBusinessMission(comments: comment,
          dateFrom: dateFromValue,dateTo: dateToValue,requestDate: requestDateValue,type: type, hourFrom: hourFromValue,hourTo: hourToValue, dateToAmpm: dateToAmpm,dateFromAmpm: dateFromAmpm);

      if (businessMissionResponse.id == 1){
        emit(
          state.copyWith(
            successMessage: businessMissionResponse.requestNo,
            status: FormzStatus.submissionSuccess,
          ),
        );
      }else{
        emit(
          state.copyWith(
            errorMessage: businessMissionResponse.id == 0 ? businessMissionResponse.result : "An error occurred",
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }
}
