import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/get_direction_screen_bloc/get_direction_cubit.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/dialogpopoup/custom_date_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/enums.dart';
import '../../../constants/request_service_id.dart';
import '../../../data/models/requests_form_models/request_date.dart';
import '../../../data/models/requests_form_models/request_date_from.dart';
import '../../../data/models/requests_form_models/request_time_from.dart';
import '../../../data/models/requests_form_models/request_time_to.dart';
import '../../../data/repositories/employee_repository.dart';

part 'business_mission_state.dart';

class BusinessMissionCubit extends Cubit<BusinessMissionInitial> {
  BusinessMissionCubit(this._requestRepository) : super(const BusinessMissionInitial());
  final RequestRepository _requestRepository;
  static BusinessMissionCubit get(context) => BlocProvider.of(context);

  void getRequestData({required RequestStatus requestStatus, String? requestNo,String? date,String? requesterHRCode,context}) async{
    if (requestStatus == RequestStatus.newRequest){
      var now = DateTime.now();
      String formattedDate = GlobalConstants.dateFormatViewed.format(now);
      final dateNow = RequestDate.dirty(formattedDate);
      if(date!=null){
        formattedDate = GlobalConstants.dateFormatViewed.format(DateTime.parse(date));
        final requestDateFrom = DateFrom.dirty(formattedDate);
        emit(
          state.copyWith(
              requestDate: dateNow,
              dateFrom: requestDateFrom,
              status: Formz.validate([dateNow,
                requestDateFrom , state.dateTo]),
              requestStatus: RequestStatus.newRequest
          ),
        );
      }else{
        emit(
          state.copyWith(
              requestDate: dateNow,
              status: Formz.validate([dateNow,
                state.timeFrom , state.dateFrom]),
              requestStatus: RequestStatus.newRequest
          ),
        );
      }
    }
    else{
      EasyLoading.show(status: 'Loading...',maskType: EasyLoadingMaskType.black,dismissOnTap: false,);
      final requestData = await _requestRepository.getBusinessMissionRequestData(requestNo ?? "",requesterHRCode ?? "");
      final requestFromDate = DateFrom.dirty(GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.dateFrom!)));
      final requestToDate = DateTo.dirty(value: GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.dateTo!)), dateFrom: requestFromDate.value);
      final requestDate = RequestDate.dirty(GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.date!)));

      var commentsRequested = requestData.comments ?? "No Comment";
      final comments = CommentCharacterCheck.dirty(commentsRequested);
      final hoursFrom  = TimeFrom.dirty("${requestData.hourFrom} ${requestData.dateFromAmpm}");
      final hoursTo  = TimeTo.dirty("${requestData.hourTo} ${requestData.dateToAmpm}");
      var status = "Pending";
      var token =  _requestRepository.userData?.user?.token;
      final requesterData = await GetEmployeeRepository().getEmployeeData(requestData.requestHrCode??"",token ?? "");
      if(requestData.status == 0){
        status = "Pending";
      }else if (requestData.status == 1){
        status = "Approved";
      }else if (requestData.status == 2){
        status = "Rejected";
      }
      final projectId = requestData.projectId ?? "";
      var missionLocation = const LocationDataCheck.dirty(type: 0, value: LocationData.empty);
      if(projectId.isNotEmpty){
        missionLocation =  LocationDataCheck.dirty(value:BlocProvider.of<GetDirectionCubit>(context).getLocationByID(projectId),type: 0);
      }

      emit(
        state.copyWith(
            requestDate: requestDate,
            dateFrom: requestFromDate,
            dateTo: requestToDate,
            missionType: int.parse(requestData.missionLocation ?? "1"),
            comment: comments,
            timeFrom: hoursFrom,
            timeTo: hoursTo,
            status: FormzStatus.valid,
            requesterData: requesterData,
            missionLocation: missionLocation,
            // status: Formz.validate([requestDate,
            //   state.timeFrom , state.dateFrom]),
            requestStatus: RequestStatus.oldRequest,
            statusAction: status,
            takeActionStatus: (_requestRepository.userData?.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction
        ),
      );
    }
  }



  void businessDateFromChanged(BuildContext context) async{
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(
        FocusNode());
    date = await openShowDatePicker(context);
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
    date = await openShowDatePicker(context);
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
    print("--> value type $value");
    final location = LocationDataCheck.dirty(value: state.missionLocation.value,type: missionType);
    emit(
      state.copyWith(
        missionType: missionType,
        missionLocation: location,
        status: Formz.validate([state.requestDate,state.dateFrom,state.timeFrom,location]),
      ),
    );
  }
  void businessTimeFromChanged(BuildContext context) async{
    TimeOfDay? time = TimeOfDay.now();
    final localizations = MaterialLocalizations
        .of(context);
    FocusScope.of(context).requestFocus(
        FocusNode());
    time = await openShowTimePicker(context);
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
    time = await openShowTimePicker(context);
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
    var comment = CommentCharacterCheck.dirty(value);
    emit(
      state.copyWith(
        comment: comment,
        status: Formz.validate([state.requestDate,state.dateFrom,state.timeFrom,comment]),
      ),
    );
  }
  void commentRequesterChanged(String value) {

    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        actionComment : value,
        // status: Formz.validate([state.requestDate,state.permissionDate,state.permissionTime]),
      ),
    );
  }

  void getLocationChanged(LocationData value) {
    // final locationData = value;
    emit(
      state.copyWith(
        missionLocation: LocationDataCheck.dirty(value: value,type: state.missionType) ,
        status: Formz.validate([state.requestDate,state.dateFrom,state.timeFrom]),
      ),
    );
  }

  Future<void> submitBusinessMissionRequest() async {
    print("submit Business Mission");
    final requestDate = RequestDate.dirty(state.requestDate.value);
    final dateFrom = DateFrom.dirty(state.dateFrom.value);
    final dateTo = DateTo.dirty(value: state.dateTo.value,dateFrom: dateFrom.value);
    final timeFrom = TimeFrom.dirty(state.timeFrom.value);
    final timeTo = TimeTo.dirty(state.timeTo.value);
    print("mission type in submit ${state.missionType}");
    final location = LocationDataCheck.dirty(value: state.missionLocation.value,type: state.missionType);
    final comment = CommentCharacterCheck.dirty(state.comment.value);

    emit(state.copyWith(
      requestDate: requestDate,
      dateFrom: dateFrom,
      dateTo: dateTo,
      timeTo: timeTo,
      timeFrom: timeFrom,
      missionLocation: location,
      comment: comment,
      status: Formz.validate([requestDate, dateFrom,dateTo,timeFrom,timeTo,location,comment]),
    ));
    if (state.status.isValidated) {
      // print("Done permission");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      // final DateFormat dateFormatViewed = DateFormat("EEEE dd-MM-yyyy");
      // final DateFormat dateFormatServer = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      // "date" -> "2022-05-17T13:47:07"
      DateTime requestDateTemp = GlobalConstants.dateFormatViewed.parse(requestDate.value);
      final requestDateValue = GlobalConstants.dateFormatServer.format(requestDateTemp);
      print("requestDateValue $requestDateValue");

      // "permissionDate" -> "2022-05-17T00:00:00"
      DateTime dateFromTemp = GlobalConstants.dateFormatViewed.parse(dateFrom.value);
      final dateFromValue = GlobalConstants.dateFormatServer.format(dateFromTemp);
      print("dateFromValue $dateFromValue");

      DateTime dateToTemp = GlobalConstants.dateFormatViewed.parse(dateTo.value);
      final dateToValue = GlobalConstants.dateFormatServer.format(dateToTemp);
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

      final locations = state.missionLocation.value;
      // print("type $type");

      // print(hrCode);


      final businessMissionResponse = await _requestRepository.postBusinessMission(comments: comment.value,
          dateFrom: dateFromValue,dateTo: dateToValue,requestDate: requestDateValue,type: type, hourFrom: hourFromValue,hourTo: hourToValue, dateToAmpm: dateToAmpm,dateFromAmpm: dateFromAmpm,locationData:locations
      );

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

  submitAction(ActionValueStatus valueStatus,String requestNo) async {

    emit(state.copyWith(status: FormzStatus.submissionInProgress,));
    final vacationResultResponse = await _requestRepository.postTakeActionRequest(
        valueStatus: valueStatus,
        requestNo: requestNo,
        actionComment: state.actionComment,
        serviceID: RequestServiceID.businessMissionServiceID,
        serviceName: GlobalConstants.requestCategoryBusinessMissionActivity,
        requesterHRCode: state.requesterData.userHrCode ?? "",
        requesterEmail: state.requesterData.email ?? "");

    final result = vacationResultResponse.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      emit(
        state.copyWith(
          successMessage: "#$requestNo \n ${valueStatus == ActionValueStatus.accept ? "Request has been Accepted":"Request has been Rejected"}",
          status: FormzStatus.submissionSuccess,
        ),
      );
    }
    else {
      emit(
        state.copyWith(
          errorMessage:"An error occurred",
          status: FormzStatus.submissionFailure,
        ),
      );
      // }
    }

  }
}
