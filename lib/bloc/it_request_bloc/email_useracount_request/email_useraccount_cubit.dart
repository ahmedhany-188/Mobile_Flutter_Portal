import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/email_user_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:heroicons/heroicons.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'email_useraccount_state.dart';

class EmailUserAccountCubit extends Cubit<EmailUserAccountInitial> {
  EmailUserAccountCubit(this.requestRepository) : super(const EmailUserAccountInitial());

  final Connectivity connectivity = Connectivity();
  static EmailUserAccountCubit get(context) => BlocProvider.of(context);

  final RequestRepository requestRepository;


  void getRequestData(RequestStatus requestStatus , String? requestNo) async {
    if (requestStatus == RequestStatus.newRequest){
      var now = DateTime.now();
      var formatter = GlobalConstants.dateFormatViewed;
      String formattedDate = formatter.format(now);
      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([state.userMobile]),
            requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
      final requestData = await requestRepository.getEmailAccount(requestNo!);

      final requestDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.requestDate!)));

      final requestType = requestData.requestType;
      final accountType = requestData.accountType;
      final userMobile = RequestDate.dirty(state.userMobile.value);
      final comments = requestData.comments!.isEmpty ? "No Comment" : requestData.comments;
      var status = "Pending";
      if (requestData.status== 0) {
        status = "Pending";
      } else if (requestData.status == 1) {
        status = "Approved";
      } else if (requestData.status == 2) {
        status = "Rejected";
      }
      emit(state.copyWith(
          requestDate: requestDate,
          userMobile: userMobile,
          requestType: requestType,
          accountType: accountType,
          comments: comments,
          status: Formz.validate([state.userMobile]),
          requestStatus: RequestStatus.oldRequest,
          statusAction: status,
          takeActionStatus: (requestRepository.userData.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction

      ));
    }
  }


    void submitEmailAccount(MainUserData userData) async{

      final userMobile = RequestDate.dirty(state.userMobile.value);
      // var status = "Pending";
      // if(requestData.status == 0){
      //   status = "Pending";
      // }else if (requestData.status == 1){
      //   status = "Approved";
      // }else if (requestData.status == 2){
      //   status = "Rejected";
      // }
    EmailUserFormModel emailUserFormModel;
      final requestDate = RequestDate.dirty(state.requestDate.value);

      // "date" -> "2022-05-17T13:47:07"
      DateTime requestDateTemp = GlobalConstants.dateFormatViewed.parse(requestDate.value);
      final requestDateValue = GlobalConstants.dateFormatServer.format(requestDateTemp);
      print("requestDateValue $requestDateValue");


    emit(state.copyWith(
        userMobile: userMobile,
        status: Formz.validate([userMobile])
    ));

      if (state.status.isValidated) {

        emailUserFormModel=EmailUserFormModel(requestDateValue,
            state.requestType, state.userMobile.value, state.accountType,false,0,0,"");
        //TODO: creation of Object;

        try {
          var connectivityResult = await connectivity.checkConnectivity();
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {

            final accessEmailUserAccount = await requestRepository
                .postEmailUserAccount(emailUserFormModel: emailUserFormModel);
            if (accessEmailUserAccount.id == 1) {
              emit(state.copyWith(successMessage: accessEmailUserAccount.requestNo,
                status: FormzStatus.submissionSuccess,
              ),
              );
            } else {

              print("-------------i am here");
              emit(state.copyWith(errorMessage: accessEmailUserAccount.id == 1
                  ? accessEmailUserAccount.result
                  : "An error occurred", status: FormzStatus.submissionFailure,
              ),
              );
            }
          } else {
            emit(
              state.copyWith(
                errorMessage: "No internet Connection",
                status: FormzStatus.submissionFailure,
              ),
            );
          }
        } catch (e) {
          print("------------can you see me");
          emit(
            state.copyWith(
              errorMessage: e.toString(),
              status: FormzStatus.submissionFailure,
            ),
          );
        }
      }
    }


  void accessRightChanged(int value){
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
