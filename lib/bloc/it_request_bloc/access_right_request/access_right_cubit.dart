import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/constants/constants.dart';
import 'package:hassanallamportalflutter/constants/enums.dart';
import 'package:hassanallamportalflutter/data/data_providers/it_request_data_provider/itaccess_right_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/it_requests_form_models/access_right_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:intl/intl.dart';

part 'access_right_state.dart';

class AccessRightCubit extends Cubit<AccessRightInitial> {
  AccessRightCubit() : super(const AccessRightInitial());

  final Connectivity connectivity = Connectivity();
  static AccessRightCubit get(context) => BlocProvider.of(context);

  void getRequestData(RequestStatus requestStatus , String? requestNo) async {
    if (requestStatus == RequestStatus.newRequest){
      var now = DateTime.now();
      String formattedDate = GlobalConstants.dateFormatViewed.format(now);
      final requestDate = RequestDate.dirty(formattedDate);
      emit(
        state.copyWith(
            requestDate: requestDate.value,
            requestStatus: RequestStatus.newRequest
        ),
      );
    }else{
    }
  }


  void getSubmitAccessRight(MainUserData user,List<String> items) async {
    final requestItem = RequestDate.dirty(state.requestItems.value);
    final fromDate = RequestDate.dirty(state.fromDate.value);
    final toDate = RequestDate.dirty(state.toDate.value);

    AccessRightModel accessRightModel;

    emit(state.copyWith(
        requestItems: requestItem,
        fromDate:fromDate,
        toDate:toDate,
        status: Formz.validate([requestItem,fromDate,toDate])
    ));

    if (state.status.isValidated) {


      accessRightModel=AccessRightModel(state.requestType,
        false,false,false,false,state.permanent, state.fromDate.value, state.toDate.value,state.requestDate!,
        state.filePDF, state.comments,items);

      try {
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          ItAccessccountRequestDataProvide(accessRightModel,user)
              .getAccessAccountAccessRequest()
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

  void accessRightChanged(int value) {
    emit(state.copyWith(
      requestType: value,
      status: Formz.validate([state.requestItems,state.fromDate,state.toDate]),
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

    // var formatter = DateFormat('EEEE dd-MM-yyyy');
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(
        currentDate ?? DateTime.now());
    final requestDate = RequestDate.dirty(formattedDate);

    if (datetype == "from") {
      emit(state.copyWith(
        fromDate: requestDate,
        status: Formz.validate([state.requestItems,requestDate,state.toDate]),
        ),
      );
    } else {
      emit(state.copyWith(
          toDate: requestDate, status: Formz.validate([state.requestItems,state.fromDate,requestDate]),
        ),
      );
    }
  }

  void getPermanentValue(bool value){
    emit(state.copyWith(
      permanent: value,
      status: Formz.validate([state.requestItems,state.fromDate,state.toDate]),
    ));
  }

  void getRequestValue(String value){
    RequestDate valueNew =const RequestDate.pure();
    if(value!="[]"){
      valueNew = RequestDate.dirty(value);
    }
    emit(state.copyWith(
      requestItems: valueNew,
      status: Formz.validate([valueNew,state.fromDate,state.toDate]),
    ));
  }

  void commentValueChanged(String value) {
    emit(state.copyWith(
      comments: value,
      status: Formz.validate([state.requestItems,state.fromDate,state.toDate]),
    ));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}



