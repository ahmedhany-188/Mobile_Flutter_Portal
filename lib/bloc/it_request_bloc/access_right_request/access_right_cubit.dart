import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:intl/intl.dart';

part 'access_right_state.dart';

class AccessRightCubit extends Cubit<AccessRightInitial> {
  AccessRightCubit(this.requestRepository) : super(const AccessRightInitial());

  final Connectivity connectivity = Connectivity();

  static AccessRightCubit get(context) => BlocProvider.of(context);

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

            status: Formz.validate(
                [state.requestItems, state.fromDate, state.toDate]),
          requestStatus: RequestStatus.newRequest,
        ),
      );
    }
    else {


      final requestData = await requestRepository.getAccessRight(requestNo!);



      final requestType = requestData.requestType;
      final usbException = requestData.usbException;
      final vpnAccount = requestData.vpnAccount;
      final ipPhone= requestData.ipPhone;
      final localAdmin = requestData.localAdmin;

      List<String> requestItems=[];
      if (usbException==true) {
        requestItems.add("USB Exception");
      }
      if (vpnAccount == true) {
        requestItems.add("VPN Account");
      }
      if (ipPhone == true) {
        requestItems.add("IP Phone");
      }
      if (localAdmin == true) {
        requestItems.add("Local Admin");
      }

      final requestDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.requestDate!)));

      final fromDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.fromDate!)));

      final toDate = RequestDate.dirty(
          GlobalConstants.dateFormatViewed.format(
              GlobalConstants.dateFormatServer.parse(requestData.toDate!)));

      final permanent = requestData.permanent;

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
          requestType: requestType,
          localAdmin: localAdmin,
          vpnAccount: vpnAccount,
          ipPhone: ipPhone,
          usbException: usbException,
          fromDate: fromDate,
          toDate: toDate,
          permanent: permanent,
          comments: comments,
            requestItemsList: requestItems,

            status: Formz.validate(
                [state.requestDate,state.requestItems, state.fromDate, state.toDate]),
          requestStatus: RequestStatus.oldRequest,
          statusAction: status,
            takeActionStatus: (requestRepository.userData.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction
        ),
      );
    }

  }


  void getSubmitAccessRight() async {
    final requestItem = RequestDate.dirty(state.requestItems.value);
    final fromDate = RequestDate.dirty(state.fromDate.value);
    final toDate = RequestDate.dirty(state.toDate.value);

    AccessRightModel accessRightModel;

    final requestDate = RequestDate.dirty(state.requestDate.value);

    // "date" -> "2022-05-17T13:47:07"
    DateTime requestDateTemp = GlobalConstants.dateFormatViewed.parse(requestDate.value);
    final requestDateValue = GlobalConstants.dateFormatServer.format(requestDateTemp);

    emit(state.copyWith(
        requestItems: requestItem,
        fromDate: fromDate,
        toDate: toDate,
        status: Formz.validate([requestItem, fromDate, toDate])
    ));

    if (state.status.isValidated) {
      accessRightModel = AccessRightModel(
          state.requestType,
          0,
          state.usbException,
          state.vpnAccount,
          state.ipPhone,
          state.localAdmin,
          state.permanent,
        requestDateValue,
        state.fromDate.value,
        state.toDate.value,
          state.filePDF,
          state.comments,
        ""
          );

      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          final accessResponse = await requestRepository
              .postAccessRightRequest(accessRightModel: accessRightModel);
          if (accessResponse.id == 1) {
            emit(state.copyWith(successMessage: accessResponse.requestNo,
              status: FormzStatus.submissionSuccess,
            ),
            );
          } else {
            emit(state.copyWith(errorMessage: accessResponse.id == 1
                ? accessResponse.result
                : "An error occurred", status: FormzStatus.submissionFailure,
            ),
            );
          }
        } else {
          emit(state.copyWith(errorMessage: "No internet Connection",
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

  void accessRightChanged(int value) {

    emit(state.copyWith(
      requestType: value,
      status: Formz.validate(
          [state.requestDate,state.requestItems, state.fromDate, state.toDate]),
    ));
  }

  // set the new date
  void selectDate(BuildContext context, String datetype) async {
    FocusScope.of(context).requestFocus(
        FocusNode());

    DateTime? currentDate = DateTime.now();

    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .copyWith()
                  .size
                  .height * 0.25,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  currentDate = value;
                },
                initialDateTime: DateTime.now(),
                minimumYear: 2020,
                maximumYear: 2023,
              ),
            );
          });
    } else {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));

      if (picked != null && picked != currentDate) {
        currentDate = picked;
      }
    }

    var formatter = GlobalConstants.dateFormatViewed;
    String formattedDate = formatter.format(
        currentDate ?? DateTime.now());
    final requestDate = RequestDate.dirty(formattedDate);



    if (datetype == "from") {
      emit(state.copyWith(
        fromDate: requestDate,
        status: Formz.validate([state.requestItems, requestDate, state.toDate]),
      ),
      );
    } else {
      emit(state.copyWith(
        toDate: requestDate,
        status: Formz.validate(
            [state.requestItems, state.fromDate, requestDate]),
      ),
      );
    }
  }

  void getPermanentValue(bool value) {
    emit(state.copyWith(
      permanent: value,
      status: Formz.validate(
          [state.requestItems, state.fromDate, state.toDate]),
    ));
  }

  void chosenItemsOptions(List<String> chosenFilter) {

    emit(state.copyWith(
      requestItemsList: chosenFilter,
      status: Formz.validate(
          [state.requestItems, state.fromDate, state.toDate]),
    ));
  }

  void getRequestValue(String value) {
    RequestDate valueNew = const RequestDate.pure();
    if (value != "[]") {
      valueNew = RequestDate.dirty(value);
    }



    emit(state.copyWith(
      requestItems: valueNew,
      usbException: value.contains("USB"),
      vpnAccount: value.contains("VPN"),
      ipPhone: value.contains("IP"),
      localAdmin: value.contains("Local"),

      status: Formz.validate([valueNew, state.fromDate, state.toDate]),
    ));
  }

  void commentValueChanged(String value) {
    emit(state.copyWith(
      comments: value,
      status: Formz.validate(
          [state.requestItems, state.fromDate, state.toDate]),
    ));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}



