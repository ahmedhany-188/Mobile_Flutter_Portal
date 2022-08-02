import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'business_card_state.dart';

class BusinessCardCubit extends Cubit<BusinessCardInitial> {
  BusinessCardCubit(this.requestRepository) : super(const BusinessCardInitial());

  final Connectivity connectivity = Connectivity();

  static BusinessCardCubit get(context) => BlocProvider.of(context);

  final RequestRepository requestRepository;

  void getRequestData(RequestStatus requestStatus, String? requestNo) async {
    if (requestStatus == RequestStatus.newRequest) {
      var now = DateTime.now();
      var formatter = GlobalConstants.dateFormatViewed;
      String formattedDate = formatter.format(now);
      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
          requestDate: requestDate,
          requestStatus: RequestStatus.newRequest,
          status: Formz.validate(
              [state.employeeNameCard, state.employeeMobile]),
        ),
      );
    }
    else {
      final requestData = await requestRepository.geBusinessCard(requestNo!);

      print("-----------" + requestData.faxNo.toString());
      print("-----------" + requestData.employeeExt.toString());
      print("-----------" + requestData.employeeNameCard.toString());
      print("-----------" + requestData.employeeMobil.toString());
      print("-----------" + requestData.employeeComments.toString());

      final requestDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(
                  requestData.requestDate!)));

      final employeeName = RequestDate.dirty(
          requestData.employeeNameCard.toString());
      final employeeComments = requestData.employeeComments.toString();
      final employeeMobile = RequestDate.dirty(
          requestData.employeeMobil.toString());
      final faxNo = requestData.faxNo.toString();
      final employeeExt = requestData.employeeExt.toString();


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
            employeeNameCard: employeeName,
            employeeMobile: employeeMobile,
            employeeExt: employeeExt,
            employeeFaxNO: faxNo,
            comment: employeeComments,
            status: Formz.validate(
                [state.employeeNameCard, state.employeeMobile]),
            requestStatus: RequestStatus.oldRequest,
            statusAction: status,
            takeActionStatus: (requestRepository.userData.user?.userHRCode ==
                requestData.requestHrCode)
                ? TakeActionStatus.view
                : TakeActionStatus.takeAction
        ),
      );
    }
  }

  void getSubmitBusinessCard(MainUserData user) async {
    final employeeName = RequestDate.dirty(state.employeeNameCard.value);
    final employeeMobile = RequestDate.dirty(state.employeeMobile.value);
    BusinessCardFormModel businessCardFormModel;


    var now = DateTime.now();
    var formatter = GlobalConstants.dateFormatServer;
    String formattedDate = formatter.format(now);

    // DateTime requestDateTemp = GlobalConstants.dateFormatViewed.parse(state.requestDate.value);
    // final requestDateValue = GlobalConstants.dateFormatServer.format(requestDateTemp);


    emit(state.copyWith(
      employeeNameCard: employeeName,
      employeeMobile: employeeMobile,
      status: Formz.validate([employeeName, employeeMobile]),
    ));

    if (state.status.isValidated) {
      businessCardFormModel = BusinessCardFormModel(
          formattedDate,
          employeeName.value,
          employeeMobile.value,
          state.employeeExt.toString(),
          state.employeeFaxNO.toString(),
          state.comment.toString(),0,
          user.employeeData!.userHrCode.toString());


      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {

          emit(state.copyWith(
              status: FormzStatus.submissionInProgress));

          final accessBusinessCardResponse = await requestRepository
              .postBusinessCard(businessCardFormModel: businessCardFormModel);

          if (accessBusinessCardResponse.id == 1) {
            emit(state.copyWith(
              successMessage: accessBusinessCardResponse.requestNo,
              status: FormzStatus.submissionSuccess,
            ),
            );
          } else {
            emit(state.copyWith(errorMessage: accessBusinessCardResponse.id == 1
                ? accessBusinessCardResponse.result
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
        emit(
          state.copyWith(
            errorMessage: e.toString(),
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }

  void nameCard(String value) {
    final name = RequestDate.dirty(value);
    emit(state.copyWith(
      employeeNameCard: name,
      status: Formz.validate([name, state.employeeMobile]),
    ));
  }

  void employeeMobile(String value) {
    final userMobile = RequestDate.dirty(value);
    emit(state.copyWith(
      employeeMobile: userMobile,
      status: Formz.validate([state.employeeNameCard, userMobile]),
    ));
  }

  void employeeExt(String value) {
    emit(state.copyWith(
      employeeExt: value,
      status: Formz.validate([state.employeeNameCard, state.employeeMobile]),
    ));
  }

  void employeeFaxNO(String value) {
    emit(state.copyWith(
      employeeFaxNO: value,
      status: Formz.validate([state.employeeNameCard, state.employeeMobile]),
    ));
  }

  void EemployeeComment(String value) {
    emit(state.copyWith(
      comment: value,
      status: Formz.validate([state.employeeNameCard, state.employeeMobile]),
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
