import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_date.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_permission_type.dart';

import '../../data/models/requests_form_models/request_date.dart';
import '../../data/models/requests_form_models/request_permission_time.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionInitial> {
  PermissionCubit() : super(PermissionInitial());
  // LoginCubit(this._authenticationRepository) : super(const LoginState());

  // final AuthenticationRepository _authenticationRepository;


  void getRequestData(RequestStatus requestStatus) {
    if (requestStatus == RequestStatus.newRequest){
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
          requestDate: requestDate,
          status: Formz.validate([requestDate, state.permissionType ,
            state.permissionTime , state.permissionDate]),
          requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
      final requestDate = RequestDate.dirty("requestDate");
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([requestDate, state.permissionType ,
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
        status: Formz.validate([permissionDate, state.permissionType,state.permissionTime,state.requestDate]),
      ),
    );
  }
  void permissionTypeChanged(String value) {
    final permissionType = PermissionType.dirty(value);
    emit(
      state.copyWith(
        permissionType: permissionType,
        status: Formz.validate([permissionType, state.permissionDate,state.permissionTime,state.requestDate]),
      ),
    );
  }
  void permissionTimeChanged(String value) {
    final permissionTime = PermissionTime.dirty(value);
    emit(
      state.copyWith(
        permissionTime: permissionTime,
        status: Formz.validate([permissionTime, state.permissionType,state.permissionDate,state.requestDate]),
      ),
    );
  }

  // Future<void> logInWithCredentials() async {
  //   if (!state.status.isValidated) return;
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //   try {
  //     await _authenticationRepository.logIn(
  //       username: state.username.value,
  //       password: state.password.value,
  //     );
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   } on LogInWithEmailAndPasswordFailureApi catch (e) {
  //     emit(
  //       state.copyWith(
  //         errorMessage: e.message,
  //         status: FormzStatus.submissionFailure,
  //       ),
  //     );
  //   } on LogInWithEmailAndPasswordFailureFirebase catch (e) {
  //     emit(
  //       state.copyWith(
  //         errorMessage: e.message,
  //         status: FormzStatus.submissionFailure,
  //       ),
  //     );
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   }
  // }
}
