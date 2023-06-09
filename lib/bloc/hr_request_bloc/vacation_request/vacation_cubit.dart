
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/contacts_related_models/contacts_data_from_api.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_from.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date_to.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:intl/intl.dart';

import '../../../constants/enums.dart';
import '../../../constants/request_service_id.dart';
import '../../../data/models/requests_form_models/request_date.dart';
import '../../../data/repositories/employee_repository.dart';
import '../../../widgets/dialogpopoup/custom_date_picker.dart';

part 'vacation_state.dart';

class VacationCubit extends Cubit<VacationInitial> {
  VacationCubit(this._requestRepository) : super(const VacationInitial());

  // LoginCubit(this._authenticationRepository) : super(const LoginState());

  final RequestRepository _requestRepository;
  static VacationCubit get(context) => BlocProvider.of(context);


  void getRequestData(
      {required RequestStatus requestStatus, String? requestNo, String? requesterHRCode, String? date}) async {
    if (requestStatus == RequestStatus.newRequest) {
      var now = DateTime.now();
      String formattedDate = GlobalConstants.dateFormatViewed.format(now);
      final dateNow = RequestDate.dirty(formattedDate);
      if (date != null) {
        formattedDate =
            GlobalConstants.dateFormatViewed.format(DateTime.parse(date));
        final requestDate = DateFrom.dirty(formattedDate);
        emit(
          state.copyWith(
              requestDate: dateNow,
              vacationFromDate: requestDate,
              status: Formz.validate([dateNow,
                requestDate, state.vacationToDate]),
              requestStatus: RequestStatus.newRequest
          ),
        );
      }
      else {
        emit(
          state.copyWith(
              requestDate: dateNow,
              status: Formz.validate([dateNow,
                state.vacationFromDate, state.vacationToDate]),
              requestStatus: RequestStatus.newRequest
          ),
        );
      }
    }
    else {
      // emit(state.copyWith(status: FormzStatus.submissionInProgress));
      EasyLoading.show(status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,);
      final requestData = await _requestRepository.getVacationRequestData(
          requestNo ?? "", requesterHRCode ?? "");

      final comments = requestData.comments!.isEmpty
          ? "No Comment"
          : requestData.comments;
      // final responsiblePerson = requestData.responsible != null ? ContactsDataFromApi(
      //     email: requestData.responsible!.contains("null")
      //         ? "No Data"
      //         : requestData.responsible,
      //     name: requestData.responsible!.contains("null") ||
      //         requestData.responsible!.isEmpty ? "No Data" : requestData
      //         .responsible):ContactsDataFromApi.empty;

      ContactsDataFromApi responsiblePerson;
      if (requestData.responsible != null) {
        responsiblePerson = ContactsDataFromApi(
            email: requestData.responsible!.contains("null")
                ? "No Data"
                : requestData.responsible,
            name: requestData.responsible!.contains("null") ||
                requestData.responsible!.isEmpty ? "No Data" : requestData
                .responsible);
      } else {
        responsiblePerson = const ContactsDataFromApi(
            email: "No Data",
            name: "No Data");
      }

      final requestDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.date!)));
      final requestFromDate = DateFrom.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.dateFrom!)));
      final requestToDate = DateTo.dirty(
          value: GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.dateTo!)),
          dateFrom: requestFromDate.value);

      print(requestToDate.value);

      var status = "Pending";
      if (requestData.status == 0) {
        status = "Pending";
      } else if (requestData.status == 1) {
        status = "Approved";
      } else if (requestData.status == 2) {
        status = "Rejected";
      }
      var token = _requestRepository.userData?.user?.token;
      final requesterData = await GetEmployeeRepository().getEmployeeData(
          requestData.requestHrCode ?? "",token ?? "");

      // print(requestData.noOfDays.toString());
      emit(
        state.copyWith(
            requestDate: requestDate,
            vacationType: int.parse(requestData.vacationType ?? "1"),
            vacationFromDate: requestFromDate,
            vacationToDate: requestToDate,
            vacationDuration: requestData.noOfDays.toString(),
            responsiblePerson: responsiblePerson,
            comment: comments,
            status: FormzStatus.valid,
            requestStatus: RequestStatus.oldRequest,
            statusAction: status,
            requesterData: requesterData,
            takeActionStatus: (_requestRepository.userData?.user?.userHRCode ==
                requestData.requestHrCode)
                ? TakeActionStatus.view
                : TakeActionStatus.takeAction
        ),
      );
    }
  }

  void vacationFromDateChanged(BuildContext context) async {
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(
        FocusNode());
    date = await openShowDatePicker(context);
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
        status: Formz.validate(
            [state.requestDate, vacationFromDate, vacationToDate]),
      ),
    );
    await getVacationDuration();
  }

  void vacationToDateChanged(BuildContext context) async {
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(
        FocusNode());
    date = await openShowDatePicker(context);
    var formatter = DateFormat(
        'EEEE dd-MM-yyyy');
    String formattedDate = formatter.format(
        date ?? DateTime.now());
    final vacationToDate = DateTo.dirty(
        dateFrom: state.vacationFromDate.value, value: formattedDate);
    emit(
      state.copyWith(
        vacationToDate: vacationToDate,
        status: Formz.validate(
            [state.requestDate, state.vacationFromDate, vacationToDate]),
      ),
    );
    await getVacationDuration();
  }

  void vacationTypeChanged(int value) async {
    final vacationType = value;
    emit(
      state.copyWith(
        vacationType: vacationType,
        status: Formz.validate(
            [state.requestDate, state.vacationFromDate, state.vacationToDate]),
      ),
    );
    await getVacationDuration();
  }

  void vacationResponsiblePersonChanged(ContactsDataFromApi value) {
    final responsiblePerson = value;
    emit(
      state.copyWith(
        responsiblePerson: responsiblePerson,
        status: Formz.validate(
            [state.requestDate, state.vacationFromDate, state.vacationToDate]),
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
        status: Formz.validate(
            [state.requestDate, state.vacationFromDate, state.vacationToDate]),
      ),
    );
  }

  void commentRequesterChanged(String value) {
    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    value=value.trim();
    emit(
      state.copyWith(
        actionComment: value,
        // status: Formz.validate([state.requestDate,state.permissionDate,state.permissionTime]),
      ),
    );
  }

  Future<void> getVacationDuration() async {
    if (state.vacationFromDate.valid && state.vacationToDate.valid) {
      final dateFromString = state.vacationFromDate.value;
      final dateToString = state.vacationToDate.value;
      final dateFrom = DateFormat("EEEE dd-MM-yyyy").parse(dateFromString);
      final dateTo = DateFormat("EEEE dd-MM-yyyy").parse(dateToString);
      var formatter = DateFormat('MM/dd/yyyy');
      //
      String formattedFromDate = formatter.format(dateFrom);
      String formattedToDate = formatter.format(dateTo);

      final durationResponse = await _requestRepository.getDurationVacation(
          state.vacationType, formattedFromDate, formattedToDate);
      if (durationResponse.result != null) {
        print(durationResponse.result![0].result);
        emit(
          state.copyWith(
            vacationDuration: durationResponse.result![0].result,
            status: Formz.validate([
              state.requestDate,
              state.vacationFromDate,
              state.vacationToDate
            ]),
          ),
        );
      }
    } else {
      return;
    }
  }

  Future<void> submitVacationRequest() async {
    print("submit permission");
    final requestDate = RequestDate.dirty(state.requestDate.value);
    final vacationFromDate = DateFrom.dirty(state.vacationFromDate.value);
    final vacationToDate = DateTo.dirty(value: state.vacationToDate.value,
        dateFrom: state.vacationFromDate.value);
    emit(state.copyWith(
      requestDate: requestDate,
      vacationFromDate: vacationFromDate,
      vacationToDate: vacationToDate,
      status: Formz.validate([requestDate, vacationFromDate, vacationToDate]),
    ));
    // emit(
    //   state.copyWith(
    //     successMessage: "testing",
    //     status: FormzStatus.submissionSuccess,
    //   ),
    // );
    if (state.status.isValidated) {
      // print("Done permission");
      // final DateFormat dateFormatViewed = DateFormat("EEEE dd-MM-yyyy");
      // final DateFormat dateFormatServer = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      // if(state.vacationDuration.isEmpty){
      //   emit(
      //     state.copyWith(
      //       errorMessage: "An error occurred, Please try again later",
      //       status: FormzStatus.submissionFailure,
      //     ),
      //   );
      // }


      // "date" -> "2022-05-17T13:47:07"
      DateTime requestDateTemp = GlobalConstants.dateFormatViewed.parse(
          requestDate.value);
      final requestDateValue = GlobalConstants.dateFormatServer.format(
          requestDateTemp);
      print("requestDateValue $requestDateValue");

      // "date" -> "2022-05-17T13:47:07"
      DateTime dateFromTemp = GlobalConstants.dateFormatViewed.parse(
          vacationFromDate.value);
      final dateFromValue = GlobalConstants.dateFormatServer.format(
          dateFromTemp);
      print("dateFromValue $dateFromValue");

      // "dateTo" -> "2022-05-17T13:47:07"
      DateTime dateToTemp = GlobalConstants.dateFormatViewed.parse(
          vacationToDate.value);
      final dateToValue = GlobalConstants.dateFormatServer.format(dateToTemp);
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

      // print(hrCode);

      final vacationResponse = await _requestRepository.postVacationRequest(
          comments: comment,
          dateFrom: dateFromValue,
          dateTo: dateToValue,
          requestDate: requestDateValue,
          type: type,
          responsibleHRCode: responsibleHRCode,
          noOfDays: noOfDays);


      if (vacationResponse.id == 1) {
        // print(permissionResponse.requestNo);
        emit(
          state.copyWith(
            successMessage: vacationResponse.requestNo,
            status: FormzStatus.submissionSuccess,
          ),
        );
      } else {
        // if (vacationResponse.id == 0) {
        // print(permissionResponse.requestNo);
        emit(
          state.copyWith(
            errorMessage: vacationResponse.id == 0
                ? vacationResponse.result
                : "An error occurred",
            status: FormzStatus.submissionFailure,
          ),
        );
        // }
      }
    }
  }

  submitAction(ActionValueStatus valueStatus,String requestNo) async {
    // EasyLoading.show(status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    //   dismissOnTap: false,);

    if ((valueStatus == ActionValueStatus.reject &&
        state.actionComment.isNotEmpty) ||
        (valueStatus == ActionValueStatus.accept)) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress,));
      final vacationResultResponse = await _requestRepository
          .postTakeActionRequest(
          valueStatus: valueStatus,
          requestNo: requestNo,
          actionComment: state.actionComment,
          serviceID: RequestServiceID.vacationServiceID,
          serviceName: GlobalConstants.requestCategoryVacationActivity,
          requesterHRCode: state.requesterData.userHrCode ?? "",
          requesterEmail: state.requesterData.email ?? "");

      final result = vacationResultResponse.result ?? "false";
      if (result.toLowerCase().contains("true")) {
        emit(
          state.copyWith(
            successMessage: "#$requestNo \n ${valueStatus ==
                ActionValueStatus.accept
                ? "Request has been Accepted"
                : "Request has been Rejected"}",
            status: FormzStatus.submissionSuccess,
          ),
        );
      }
      else {
        emit(
          state.copyWith(
            errorMessage: "An error occurred",
            status: FormzStatus.submissionFailure,
          ),
        );
        // }
      }
    } else {
      EasyLoading.showError('Add a rejection comment');
    }
  }

}
