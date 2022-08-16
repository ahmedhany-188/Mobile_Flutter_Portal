import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
            status: Formz.validate([state.userMobile,state.hrCodeUser]),
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
      final userMobile = RequestDate.dirty(requestData.userMobile.toString());
      final hrCodeUser = RequestDate.dirty(requestData.requestHrCode.toString());
      final fullName = requestData.fullName.toString();
      final title = requestData.title.toString();
      final location = requestData.location.toString();

      final comments = requestData.comments ?? "No Comment";
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
          hrCodeUser: hrCodeUser,
          requestType: requestType,
          accountType: accountType,
          fullName: fullName,
          userLocation: location,
          userTitle: title,
          comments: comments,
          status: Formz.validate([state.userMobile,state.hrCodeUser]),
          requestStatus: RequestStatus.oldRequest,
          statusAction: status,
          takeActionStatus: (requestRepository.userData.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction

      ));
    }
  }

  void clearStateHRCode(){
    final hrCodeUser = RequestDate.dirty("");
    final userMobile = RequestDate.dirty("");

    emit(state.copyWith(
      fullName: "",
      userTitle: "",
      userLocation: "",
      email: "",
      userMobile: userMobile,
      hrCodeUser:hrCodeUser,
      status: Formz.validate([userMobile, hrCodeUser]),
    ));




  }

  void hrCodeSubmittedGetData(String hrCode) async {

    final requestData = await requestRepository.getEmailData(hrCode);

    if (requestData == "error") {

      clearStateHRCode();

      emit(state.copyWith(errorMessage: "Invalid hr code", status:FormzStatus.submissionFailure ));
    } else {

      final fullName = requestData.name.toString();
      final titleEmployee = requestData.titleName.toString();
      final locationEmployee = requestData.projectName.toString();
      final emailEmployee = requestData.email.toString();
      final userMobile = RequestDate.dirty(requestData.mobile.toString());

      emit(state.copyWith(
        fullName: fullName,
        userTitle: titleEmployee,
        userLocation: locationEmployee,
        email: emailEmployee,
        userMobile: userMobile,
        status: Formz.validate([userMobile, state.hrCodeUser]),
      ));
    }
  }


    void submitEmailAccount() async{

      final userMobile = RequestDate.dirty(state.userMobile.value);
      final hrCodeUser = RequestDate.dirty(state.hrCodeUser.value);
      final fullName = RequestDate.dirty(state.fullName.toString());
      final title =  RequestDate.dirty(state.userTitle.toString());
      final location= RequestDate.dirty(state.userLocation.toString());
      final email= RequestDate.dirty(state.email.toString());
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


    emit(state.copyWith(
        userMobile: userMobile,
        hrCodeUser:hrCodeUser,
        status: Formz.validate([userMobile,hrCodeUser])
    ));

      if (state.status.isValidated) {

        emailUserFormModel=EmailUserFormModel(requestDateValue,
            state.requestType, state.userMobile.value, state.accountType,false,state.hrCodeUser.value,0,"",location.value,
            title.value,fullName.value,email.value);
        //TODO: creation of Object;

        emit(state.copyWith(
            status: FormzStatus.submissionInProgress));
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
      status: Formz.validate([state.userMobile,state.hrCodeUser]),
    ));
  }

  void getEmailValue(bool value){
    emit(state.copyWith(
      accountType: value,
      status: Formz.validate([state.userMobile,state.hrCodeUser]),
    ));
  }

  void phoneNumberChanged(String value){
    final userMobile = RequestDate.dirty(value);
    emit(state.copyWith(
      userMobile: userMobile,
      status: Formz.validate([userMobile,state.hrCodeUser]),
    ));
  }



  void hrCodeChanged(String value){
    final hrCodeUser = RequestDate.dirty(value);
    emit(state.copyWith(
      hrCodeUser: hrCodeUser,
      status: Formz.validate([state.userMobile,hrCodeUser]),
    ));
  }



  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    EasyLoading.dismiss();

    return super.close();
  }

}
