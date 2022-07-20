import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../constants/enums.dart';
import '../../../data/models/requests_form_models/request_date.dart';
import '../../../data/models/requests_form_models/request_permission_time.dart';
part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionInitial> {
  PermissionCubit(this._requestRepository) : super(const PermissionInitial());
  // LoginCubit(this._authenticationRepository) : super(const LoginState());

  final RequestRepository _requestRepository;


  void getRequestData({required RequestStatus requestStatus,String ?requestNo,String ?date})
  async {
    if (requestStatus == RequestStatus.newRequest) {
      var now = DateTime.now();
      String formattedDate = GlobalConstants.dateFormatViewed.format(now);

      if(date!=null){
         formattedDate = GlobalConstants.dateFormatViewed.format(DateTime.parse(date));
      }else{
         formattedDate = GlobalConstants.dateFormatViewed.format(now);
      }

      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([requestDate,
              state.permissionTime, state.permissionDate]),
            requestStatus: RequestStatus.newRequest
        ),
      );

    } else {

      final requestData = await _requestRepository.getPermissionRequestData(
          requestNo!);

      final permissionDate = PermissionDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(
                  requestData.permissionDate!)));
      // final requestToDate = DateTo.dirty(value: GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.dateTo!)), dateFrom: requestFromDate.value);
      final requestDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.date!)));
      final comments = requestData.comments!.isEmpty
          ? "No Comment"
          : requestData.comments;
      // final hoursFrom  = TimeFrom.dirty("${requestData.hourFrom} ${requestData.dateFromAmpm}");
      // final hoursTo  = TimeTo.dirty("${requestData.hourTo} ${requestData.dateToAmpm}");
      final permissionTime = PermissionTime.dirty(
          "${requestData.dateFrom} ${requestData.dateFromAmpm}");

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
            requestDate: requestDate,
            permissionDate: permissionDate,
            permissionType: requestData.type,
            permissionTime: permissionTime,

            status: Formz.validate([requestDate,
              state.permissionTime, state.permissionDate]),
            requestStatus: RequestStatus.oldRequest,
            comment: comments,
            statusAction: status,
            takeActionStatus: (_requestRepository.userData.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction

        ),
      );
    }
  }

  void permissionDateChanged(BuildContext context)async {
    FocusScope.of(context).requestFocus(
        FocusNode());
    DateTime? date = DateTime.now();
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
                  date = value;
                },
                initialDateTime: DateTime.now(),
                minimumYear: 2020,
                maximumYear: 2100,
              ),
            );
          });
    } else {
      date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100));
    }
    var formatter = DateFormat(
        'EEEE dd-MM-yyyy');
    String formattedDate = formatter.format(
        date ?? DateTime.now());
    final permissionDate = PermissionDate.dirty(formattedDate);
    print(permissionDate.value);
    emit(
      state.copyWith(
        permissionDate: permissionDate,
        status: Formz.validate([state.requestDate,permissionDate, state.permissionTime]),
      ),
    );
  }
  void permissionTypeChanged(int value) {
    final permissionType = value;
    emit(
      state.copyWith(
        permissionType: permissionType,
        status: Formz.validate([state.requestDate,state.permissionDate,state.permissionTime]),
      ),
    );
  }
  void permissionTimeChanged(BuildContext context) async {
    TimeOfDay? time = TimeOfDay.now();
    FocusScope.of(context).requestFocus(
        FocusNode());
    final localizations = MaterialLocalizations
        .of(context);

    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS){
      await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.25,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  time = TimeOfDay.fromDateTime(value);
                },
                initialDateTime: DateTime.now(),
                minimumYear: 2020,
                maximumYear: 2100,
              ),
            );
          });
    }else{
      time = await showTimePicker(context: context,
          initialTime: TimeOfDay.now());
    }

    final formattedTimeOfDay = localizations
        .formatTimeOfDay(
        time ?? TimeOfDay.now());

    final permissionTime = PermissionTime.dirty(formattedTimeOfDay);
    print(permissionTime.value);
    emit(
      state.copyWith(
        permissionTime: permissionTime,
        status: Formz.validate([state.requestDate,state.permissionDate,permissionTime]),
      ),
    );
  }
  void commentChanged(String value) {

    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
        comment: value,
        status: Formz.validate([state.requestDate,state.permissionDate,state.permissionTime]),
      ),
    );
  }

  Future<void> submitPermissionRequest() async {
    print("submit permission");
    final requestDate = RequestDate.dirty(state.requestDate.value);
    final permissionDate = PermissionDate.dirty(state.permissionDate.value);
    final permissionTime = PermissionTime.dirty(state.permissionTime.value);
    print(permissionDate.value);
    emit(state.copyWith(
      requestDate: requestDate,
      permissionDate: permissionDate,
      permissionTime: permissionTime,
      status: Formz.validate([requestDate, permissionDate,permissionTime]),
    ));

    if (state.status.isValidated) {
      // print("Done permission");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      // "date" -> "2022-05-17T13:47:07"
      DateTime requestDateTemp = DateFormat("EEEE dd-MM-yyyy").parse(requestDate.value);
      final requestDateValue = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(requestDateTemp);
      print("requestDateValue $requestDateValue");

      // "permissionDate" -> "2022-05-17T00:00:00"
      DateTime permissionDateTemp = DateFormat("EEEE dd-MM-yyyy").parse(permissionDate.value);
      final permissionDateValue = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(permissionDateTemp);
      print("permissionDateValue $permissionDateValue");
      // "comments" -> "Aaaaa"
      final comment = state.comment;
      print("comment $comment");

      // "dateFromAmpm" -> "PM"
      // "dateFrom" -> "1"
      DateTime date2= DateFormat("hh:mm a").parse(permissionTime.value);
      final dateFrom = DateFormat("hh").format(date2);
      print("dateFrom $dateFrom");
      final dateFromAmpm = DateFormat("a").format(date2);
      print("dateFromAmpm $dateFromAmpm");


      // final dateFrom = permissionTime.value.split(":")[0];
      // final dateFromAmpm = permissionTime.value.split(" ")[1];
      // print(permissionTime.value.split(":")[0]);
      // print(permissionTime.value.split(" ")[1]);

      // "dateTo" -> "3"
      // "dateToAmpm" -> "PM"
      final dateTo = DateFormat("hh").format(date2.add(Duration(hours: state.permissionType)));
      print("dateTo $dateTo");

      final dateToAmpm = DateFormat("a").format(date2.add(Duration(hours: state.permissionType)));
      print("dateToAmpm $dateToAmpm");

      final type = state.permissionType;
      print("type $type");

      // print(hrCode);

      final permissionResponse = await _requestRepository.postPermissionRequest(comments: comment,
          dateFrom: dateFrom,dateFromAmpm: dateFromAmpm,dateTo: dateTo,dateToAmpm: dateToAmpm,
          permissionDate: permissionDateValue,requestDate: requestDateValue,type: type);

      if (permissionResponse.id == 1){
        // print(permissionResponse.requestNo);
        emit(
          state.copyWith(
            successMessage: permissionResponse.requestNo,
            status: FormzStatus.submissionSuccess,
          ),
        );
      }else{
        emit(
          state.copyWith(
            errorMessage: permissionResponse.id == 0 ? permissionResponse.result : "An error occurred",
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }

    // }
    // try {
    //   await _authenticationRepository.logIn(
    //     username: state.username.value,
    //     password: state.password.value,
    //   );
    //   emit(state.copyWith(status: FormzStatus.submissionSuccess));
    // } on LogInWithEmailAndPasswordFailureApi catch (e) {
    //   emit(
    //     state.copyWith(
    //       errorMessage: e.message,
    //       status: FormzStatus.submissionFailure,
    //     ),
    //   );
    // } on LogInWithEmailAndPasswordFailureFirebase catch (e) {
    //   emit(
    //     state.copyWith(
    //       errorMessage: e.message,
    //       status: FormzStatus.submissionFailure,
    //     ),
    //   );
    // } catch (_) {
    //   emit(state.copyWith(status: FormzStatus.submissionFailure));
    // }

  }
}
