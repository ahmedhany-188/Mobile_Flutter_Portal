import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_type.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';

import '../../../constants/enums.dart';
import '../../../data/models/requests_form_models/request_date.dart';
import '../../../data/models/requests_form_models/request_permission_time.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionInitial> {
  PermissionCubit(this._requestRepository) : super(const PermissionInitial());
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
            state.permissionTime , state.permissionDate]),
          requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
      final requestDate = RequestDate.dirty("requestDate");
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([requestDate,
              state.permissionTime , state.permissionDate]),
            requestStatus: RequestStatus.oldRequest
        ),
      );
    }
  }

  void permissionDateChanged(String value) {
    final permissionDate = PermissionDate.dirty(value);
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
  void permissionTimeChanged(String value) {

    final permissionTime = PermissionTime.dirty(value);
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

  Future<void> submitPermissionRequest(String hrCode) async {
    print("submit permission");
    final requestDate = RequestDate.dirty(state.requestDate.value);
    final permissionDate = PermissionDate.dirty(state.permissionDate.value);
    final permissionTime = PermissionTime.dirty(state.permissionTime.value);
    emit(state.copyWith(
      requestDate: requestDate,
      permissionDate: permissionDate,
      permissionTime: permissionTime,
      status: Formz.validate([requestDate, permissionDate]),
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

      final type = state.permissionType == 2 ? 0 : 1;
      print("type $type");

      print(hrCode);

      final permissionResponse = await _requestRepository.postPermissionRequest(hrCode: hrCode,comments: comment,
          dateFrom: dateFrom,dateFromAmpm: dateFromAmpm,dateTo: dateTo,dateToAmpm: dateToAmpm,
          permissionDate: permissionDateValue,requestDate: requestDateValue,type: type);

      if (permissionResponse.id == 0) {
        // print(permissionResponse.requestNo);
        emit(
          state.copyWith(
            errorMessage: permissionResponse.result,
            status: FormzStatus.submissionFailure,
          ),
        );
      } else if (permissionResponse.id == 1){
        // print(permissionResponse.requestNo);
        emit(
          state.copyWith(
            successMessage: permissionResponse.requestNo,
            status: FormzStatus.submissionSuccess,
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
