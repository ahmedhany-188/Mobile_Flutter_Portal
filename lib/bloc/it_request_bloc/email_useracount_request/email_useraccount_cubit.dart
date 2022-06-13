import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/data_providers/it_request_data_provider/itemail_anduseraccount_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:meta/meta.dart';

part 'email_useraccount_state.dart';

class EmailUserAccountCubit extends Cubit<EmailUserAccountInitial> {
  EmailUserAccountCubit() : super(const EmailUserAccountInitial());

  final Connectivity connectivity = Connectivity();
  static EmailUserAccountCubit get(context) => BlocProvider.of(context);



  void getSubmitEmailAndUserAccount(MainUserData user,String date) async {
    final userMobile = RequestDate.dirty(state.userMobile.value);

    EmailUserFormModel emailUserFormModel;

    emit(state.copyWith(
        userMobile: userMobile,
        status: Formz.validate([userMobile])
    ));

      if (state.status.isValidated) {

        emailUserFormModel=EmailUserFormModel(date,
            state.requestType, state.userMobile.value, state.accountType);

        //TODO: creation of Object;

        try {
          var connectivityResult = await connectivity.checkConnectivity();
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {
            ItUserAccountRequestDataProvider(emailUserFormModel,user)
                .getuserAccountAccessRequest()
                .then((value) {
              emit(
                state.copyWith(
                  successMessage: value.body.toString(),
                  status: FormzStatus.submissionSuccess,
                ),
              );
            }).catchError((error) {
              // emit(BlocgetTheMedicalRequestErrorState(error.toString()));
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
          }
        } catch (e) {
          emit(
            state.copyWith(
              errorMessage: e.toString(),
              status: FormzStatus.submissionFailure,
            ),
          );
        }
      }
    }

  void accesRightChanged(int value){
    emit(state.copyWith(
      requestType: value,
      status: Formz.validate([state.userMobile]),
    ));
  }

  void getEmailValue(bool value){
    emit(state.copyWith(
      accountType: value,
      status: Formz.validate([state.userMobile]),
    ));
  }

  void phoneNumberChanged(String value){
    final userMobile = RequestDate.dirty(value);
    emit(state.copyWith(
      userMobile: userMobile,
      status: Formz.validate([userMobile]),
    ));
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
