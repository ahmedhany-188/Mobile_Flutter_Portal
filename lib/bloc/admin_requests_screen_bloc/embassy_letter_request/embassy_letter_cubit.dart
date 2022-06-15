import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/embassy_letter_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'embassy_letter_state.dart';

class EmbassyLetterCubit extends Cubit<EmbassyLetterInitial> {
  EmbassyLetterCubit(this.requestRepository) : super(EmbassyLetterInitial());

  final Connectivity connectivity = Connectivity();

  static EmbassyLetterCubit get(context) => BlocProvider.of(context);

  final RequestRepository requestRepository;


  void getSubmitEmbassyLetter(MainUserData user, String date) async {
    final fromDate = RequestDate.dirty(state.dateFrom.value);
    final toDate = RequestDate.dirty(state.dateTo.value);
    final passportNO = RequestDate.dirty(state.passportNumber.value);


    EmbassyLetterFormModel embassyLetterFormModel;

    emit(state.copyWith(
      dateFrom: fromDate,
      dateTo: toDate,
      passportNumber: passportNO,
      status: Formz.validate([fromDate, toDate, passportNO]),
    ));
    if (state.status.isValidated) {
      embassyLetterFormModel = EmbassyLetterFormModel(date, state.purpose, state.embassy,
          state.dateFrom.value,
          state.dateTo.value,
          state.passportNumber.value,
          state.salary, state.comments);
      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          final embassyLetterResponse = await requestRepository.postEmbassyLetter(embassyLetterFormModel: embassyLetterFormModel);
          if (embassyLetterResponse.id == 1) {
            emit(
              state.copyWith(
                successMessage: embassyLetterResponse.requestNo,
                status: FormzStatus.submissionSuccess,
              ),
            );
          }else{
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
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(
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
    final _value = RequestDate.dirty(value);
    emit(state.copyWith(
      passportNumber: _value,
      status: Formz.validate([state.dateFrom, state.dateTo, _value]),
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
