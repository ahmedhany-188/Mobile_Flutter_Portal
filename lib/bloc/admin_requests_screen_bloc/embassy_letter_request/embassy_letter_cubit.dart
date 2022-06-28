import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import '../../../constants/enums.dart';
import '../../../data/models/admin_requests_models/passport_form_model.dart';

part 'embassy_letter_state.dart';

class EmbassyLetterCubit extends Cubit<EmbassyLetterInitial> {
  EmbassyLetterCubit(this._requestRepository) : super(const EmbassyLetterInitial());

  final Connectivity connectivity = Connectivity();

  static EmbassyLetterCubit get(context) => BlocProvider.of(context);

  final RequestRepository _requestRepository;


  void getRequestData(RequestStatus requestStatus, String? requestNo) async{
    if (requestStatus == RequestStatus.newRequest){
      var now = DateTime.now();
      var formatter = GlobalConstants.dateFormatViewed;
      String formattedDate = formatter.format(now);
      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
            requestDate: requestDate,
            status: Formz.validate([requestDate,
              state.dateTo , state.dateFrom]),
            requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
      final requestData = await _requestRepository.getEmbassyLetter(requestNo!);
      final requestDate = RequestDate.dirty(GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.requestDate!)));
      final purpose = requestData.purpose;
      final country = requestData.embassy;
      final requestFromDate = RequestDate.dirty(GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.dateFrom!)));
      final requestToDate = RequestDate.dirty(GlobalConstants.dateFormatViewed.format(GlobalConstants.dateFormatServer.parse(requestData.dateTo!)));
      final passportNumber = PassportNumber.dirty(requestData.passportNo.toString());
      final salary = requestData.addSalary;
      final comments = requestData.comments!.isEmpty ? "No Comment" : requestData.comments;


      var status = "Pending";

      if(requestData.status == 0){
        status = "Pending";
      }else if (requestData.status == 1){
        status = "Approved";
      }else if (requestData.status == 2){
        status = "Rejected";
      }

      emit(
        state.copyWith(
            requestDate: requestDate,
            purpose: purpose,
            embassy: country,
            dateFrom: requestFromDate,
            dateTo: requestToDate,
            passportNumber: passportNumber,
            salary: salary,
            comments: comments,

            status: Formz.validate([state.dateFrom, state.dateTo, state.passportNumber]),
            requestStatus: RequestStatus.oldRequest,
            statusAction: status,
            takeActionStatus: (_requestRepository.userData.user?.userHRCode == requestData.requestHrCode)? TakeActionStatus.view : TakeActionStatus.takeAction
        ),
      );
    }
  }

  void submitEmbassyLetter() async {

    final requestDate = RequestDate.dirty(state.requestDate.value);
    final fromDate = RequestDate.dirty(state.dateFrom.value);
    final toDate = RequestDate.dirty(state.dateTo.value);
    final passportNO = PassportNumber.dirty(state.passportNumber.value);


    EmbassyLetterFormModel embassyLetterFormModel;
    emit(state.copyWith(
      requestDate: requestDate,
      dateFrom: fromDate,
      dateTo: toDate,
      passportNumber: passportNO,
      status: Formz.validate([fromDate, toDate, passportNO]),
    ));
    if (state.status.isValidated) {
      embassyLetterFormModel = EmbassyLetterFormModel(state.requestDate.value,
          state.purpose,
          state.embassy,
          state.dateFrom.value,
          state.dateTo.value,
          state.passportNumber.value,
          state.salary,
          state.comments,0,"0");
      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          final embassyLetterResponse = await _requestRepository.postEmbassyLetter(embassyLetterFormModel: embassyLetterFormModel);
          if (embassyLetterResponse.id == 1) {
            emit(
              state.copyWith(
                successMessage: embassyLetterResponse.requestNo,
                status: FormzStatus.submissionSuccess,
              ),
            );
          }
          else{
                emit(state.copyWith(errorMessage: embassyLetterResponse.id == 1
                    ? embassyLetterResponse.result
                    : "An error occurred", status: FormzStatus.submissionFailure,
              ),
            );
          };
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

    // var formatter = DateFormat('EEEE dd-MM-yyyy');
    // var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = GlobalConstants.dateFormatViewed.format(
        currentDate ?? DateTime.now());
    final requestDate = RequestDate.dirty(formattedDate);

    if (datetype == "from") {
      emit(state.copyWith(
        dateFrom: requestDate,
        status: Formz.validate(
            [requestDate, state.dateTo, state.passportNumber]),
      ),
      );
    } else {
      emit(state.copyWith(
        dateTo: requestDate,
        status: Formz.validate(
            [state.dateFrom, requestDate, state.passportNumber]),
      ),
      );
    }
  }


  void addSelectedPurpose(String value) {
    emit(state.copyWith(
      purpose: value,
      status: Formz.validate(
          [state.dateFrom, state.dateTo, state.passportNumber]),
    ));
  }

  void addSelectedEmbassy(String value) {
    emit(state.copyWith(
      embassy: value,
      status: Formz.validate(
          [state.dateFrom, state.dateTo, state.passportNumber]),
    ));
  }

  void passportNo(String value) {
    final passportNumber = PassportNumber.dirty(value);
    emit(state.copyWith(
      passportNumber: passportNumber,
      status: Formz.validate([state.dateFrom, state.dateTo, passportNumber]),
    ));
  }


  void addSelectedSalary(String value) {
    emit(state.copyWith(
      salary: value,
      status: Formz.validate(
          [state.dateFrom, state.dateTo, state.passportNumber]),
    ));
  }


  void comments(String value) {
    emit(state.copyWith(
      comments: value,
      status: Formz.validate(
          [state.dateFrom, state.dateTo, state.passportNumber]),
    ));
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
