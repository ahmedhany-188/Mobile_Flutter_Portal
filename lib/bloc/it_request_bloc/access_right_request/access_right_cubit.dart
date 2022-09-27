import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/data_providers/general_dio/general_dio.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';

import '../../../constants/request_service_id.dart';
import '../../../data/repositories/employee_repository.dart';
import '../../../widgets/dialogpopoup/custom_date_picker.dart';

part 'access_right_state.dart';

class AccessRightCubit extends Cubit<AccessRightInitial> {
  AccessRightCubit(this.requestRepository) : super(const AccessRightInitial());

  final Connectivity connectivity = Connectivity();

  static AccessRightCubit get(context) => BlocProvider.of(context);

  final RequestRepository requestRepository;

  void getRequestData(
      {required RequestStatus requestStatus,
      String? requestNo,
      String? requesterHRCode}) async {
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
    } else {
      EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
      final requestData = await requestRepository.getAccessRight(
          requestNo ?? "", requesterHRCode ?? "");
      final requestType = requestData.requestType;
      final usbException = requestData.usbException;
      final vpnAccount = requestData.vpnAccount;
      final ipPhone = requestData.ipPhone;
      final localAdmin = requestData.localAdmin;
      final printing = requestData.printing;

      List<String> requestItems = [];
      if (usbException == true) {
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
      if (printing == true) {
        requestItems.add("Color Printing");
      }

      final requestDate = RequestDate.dirty(GlobalConstants.dateFormatViewed
          .format(GlobalConstants.dateFormatServer
              .parse(requestData.requestDate!)));

      final fromDate = RequestDate.dirty(GlobalConstants.dateFormatViewed
          .format(
              GlobalConstants.dateFormatServer.parse(requestData.fromDate!)));

      final toDate = RequestDate.dirty(GlobalConstants.dateFormatViewed
          .format(GlobalConstants.dateFormatServer.parse(requestData.toDate!)));

      final permanent = requestData.permanent;

      final comments = requestData.comments ?? "No Comment";

      final filePdf = requestData.filePDF ?? '';

      final requesterData = await GetEmployeeRepository()
          .getEmployeeData(requestData.requestHrCode ?? "");

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
            requestType: requestType,
            localAdmin: localAdmin,
            vpnAccount: vpnAccount,
            ipPhone: ipPhone,
            usbException: usbException,
            printing: printing,
            fromDate: fromDate,
            toDate: toDate,
            permanent: permanent,
            comments: comments,
            requestItemsList: requestItems,
            requesterData: requesterData,
            status: FormzStatus.valid,
            requestStatus: RequestStatus.oldRequest,
            statusAction: status,
            filePDF: filePdf,
            takeActionStatus: (requestRepository.userData?.user?.userHRCode ==
                    requestData.requestHrCode)
                ? TakeActionStatus.view
                : TakeActionStatus.takeAction),
      );
    }
  }

  void getSubmitAccessRight() async {
    final requestItem = RequestDate.dirty(state.requestItems.value);
    final fromDate = RequestDate.dirty(state.fromDate.value);
    final toDate = RequestDate.dirty(state.toDate.value);
    final requestDate = RequestDate.dirty(state.requestDate.value);

    emit(state.copyWith(
        requestItems: requestItem,
        requestDate: requestDate,
        fromDate: fromDate,
        toDate: toDate,
        status: Formz.validate([requestItem, fromDate, toDate])));

    if (state.status.isValidated) {
      AccessRightModel accessRightModel;

      DateTime requestDateTemp =
          GlobalConstants.dateFormatViewed.parse(requestDate.value);
      final requestDateValue =
          GlobalConstants.dateFormatServer.format(requestDateTemp);

      DateTime requestDateTempFrom =
          GlobalConstants.dateFormatViewed.parse(fromDate.value);
      final requestDateValueFrom =
          GlobalConstants.dateFormatServer.format(requestDateTempFrom);

      DateTime requestDateTempTo =
          GlobalConstants.dateFormatViewed.parse(toDate.value);
      final requestDateValueTo =
          GlobalConstants.dateFormatServer.format(requestDateTempTo);

      accessRightModel = AccessRightModel(
          state.requestType,
          0,
          state.usbException,
          state.vpnAccount,
          state.ipPhone,
          state.localAdmin,
          state.printing,
          state.permanent,
          requestDateValue,
          requestDateValueFrom,
          requestDateValueTo,
          state.filePDF,
          state.comments,
          "");

      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          emit(state.copyWith(status: FormzStatus.submissionInProgress));

          final accessResponse = await requestRepository.postAccessRightRequest(
              accessRightModel: accessRightModel);

          ///TODO: check error
          var fileName = accessResponse.requestNo;
          if (state.fileResult.isSinglePick) {
            GeneralDio.uploadAccessRightImage(
                    state.fileResult, fileName!, state.extension)
                .then((value) {
              emit(state.copyWith(filePDF: value.data?[0]));
            }).catchError((err) {
              throw err;
            });
          }

          if (accessResponse.id == 1) {
            emit(
              state.copyWith(
                successMessage: accessResponse.requestNo,
                status: FormzStatus.submissionSuccess,
              ),
            );
          } else {
            emit(
              state.copyWith(
                errorMessage: accessResponse.id == 1
                    ? accessResponse.result
                    : "An error occurred",
                status: FormzStatus.submissionFailure,
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
    } else {
      if (state.requestItemsList.toString() == "[]") {
        emit(
          state.copyWith(
            errorMessage: "Select at least one item",
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }
  }

  void accessRightChanged(int value) {
    emit(state.copyWith(
      requestType: value,
      status: Formz.validate([
        state.requestDate,
        state.requestItems,
        state.fromDate,
        state.toDate
      ]),
    ));
  }

  // set the new date
  void selectDate(BuildContext context, String dateType) async {
    FocusScope.of(context).requestFocus(FocusNode());

    DateTime? currentDate = DateTime.now();

    // if (defaultTargetPlatform == TargetPlatform.macOS ||
    //     defaultTargetPlatform == TargetPlatform.iOS) {
    //   await showCupertinoModalPopup(
    //       context: context,
    //       builder: (BuildContext builder) {
    //         return Container(
    //           height: MediaQuery
    //               .of(context)
    //               .copyWith()
    //               .size
    //               .height * 0.25,
    //           color: Colors.white,
    //           child: CupertinoDatePicker(
    //             mode: CupertinoDatePickerMode.date,
    //             onDateTimeChanged: (value) {
    //               currentDate = value;
    //             },
    //             initialDateTime: DateTime.now(),
    //             minimumYear: 2020,
    //             maximumYear: 2023,
    //           ),
    //         );
    //       });
    // }
    // else {
    //   final DateTime? picked = await showDatePicker(
    //       context: context,
    //       initialDate: currentDate,
    //       firstDate: DateTime.now(),
    //       lastDate: DateTime(2101));
    //
    //   if (picked != null && picked != currentDate) {
    //     currentDate = picked;
    //   }
    // }
    currentDate = await openShowDatePicker(context);

    var formatter = GlobalConstants.dateFormatViewed;
    String formattedDate = formatter.format(currentDate ?? DateTime.now());
    final requestDate = RequestDate.dirty(formattedDate);

    if (dateType == "from") {
      emit(
        state.copyWith(
          fromDate: requestDate,
          status:
              Formz.validate([state.requestItems, requestDate, state.toDate]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          toDate: requestDate,
          status:
              Formz.validate([state.requestItems, state.fromDate, requestDate]),
        ),
      );
    }
  }

  void getPermanentValue(bool value) {
    emit(state.copyWith(
      permanent: value,
      status:
          Formz.validate([state.requestItems, state.fromDate, state.toDate]),
    ));
  }

  void chosenItemsOptions(List<String> chosenFilter) {
    emit(state.copyWith(
      requestItemsList: chosenFilter,
      status:
          Formz.validate([state.requestItems, state.fromDate, state.toDate]),
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
      printing: value.contains("Color"),
      status: Formz.validate([valueNew, state.fromDate, state.toDate]),
    ));
  }

  void commentValueChanged(String value) {
    emit(state.copyWith(
      comments: value,
      status:
          Formz.validate([state.requestItems, state.fromDate, state.toDate]),
    ));
  }

  void commentRequesterChanged(String value) {
    // final permissionTime = PermissionTime.dirty(value);
    // print(permissionTime.value);
    emit(
      state.copyWith(
          // actionComment : value,
          // status: Formz.validate([state.requestDate,state.permissionDate,state.permissionTime]),
          ),
    );
  }

  void setChosenFileName() async {
    String extension = '';
    String chosenFileName = '';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      extension = result.files.first.extension!;
      chosenFileName = result.files.first.name;
    }
    emit(state.copyWith(
        extension: extension,
        fileResult: result,
        chosenFileName: chosenFileName));
  }

  submitAction(ActionValueStatus valueStatus, String requestNo) async {
    // EasyLoading.show(status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    //   dismissOnTap: false,);
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    final vacationResultResponse =
        await requestRepository.postTakeActionRequest(
            valueStatus: valueStatus,
            requestNo: requestNo,
            actionComment: state.actionComment,
            serviceID: RequestServiceID.accessRightServiceID,
            serviceName: GlobalConstants.requestCategoryAccessRight,
            requesterHRCode: state.requesterData.userHrCode ?? "",
            requesterEmail: state.requesterData.email ?? "");

    final result = vacationResultResponse.result ?? "false";
    if (result.toLowerCase().contains("true")) {
      emit(
        state.copyWith(
          successMessage:
              "#$requestNo \n ${valueStatus == ActionValueStatus.accept ? "Request has been Accepted" : "Request has been Rejected"}",
          status: FormzStatus.submissionSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          errorMessage: "An error occurred",
          status: FormzStatus.submissionFailure,
        ),
      );
      // }
    }
  }

  @override
  Future<void> close() {
    // connectivityStreamSubscription?.cancel();
    EasyLoading.dismiss();

    return super.close();
  }
}
