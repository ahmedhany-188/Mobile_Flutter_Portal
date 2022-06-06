import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hassanallamportalflutter/data/data_providers/admin_request_data_provider/business_card_data_provider.dart';
import 'package:hassanallamportalflutter/data/models/admin_requests_models/business_card_form_model.dart';
import 'package:hassanallamportalflutter/data/models/requests_form_models/request_date.dart';
import 'package:meta/meta.dart';

part 'business_card_state.dart';

class BusinessCardCubit extends Cubit<BusinessCardInitial> {
  BusinessCardCubit() : super(BusinessCardInitial());

  final Connectivity connectivity = Connectivity();
  static BusinessCardCubit get(context) => BlocProvider.of(context);

  void getSubmitBusinessCard(MainUserData user,String date) async{


    final employeeName = RequestDate.dirty(state.employeeNameCard.value);
    final employeeMobile = RequestDate.dirty(state.employeeMobile.value);

    BusinessCardFormModel _businessCardFormModel;

    emit(state.copyWith(
      employeeNameCard: employeeName,
      employeeMobile: employeeMobile,
      status: Formz.validate([employeeName,employeeMobile]),
    ));

    if(state.status.isValidated){

      _businessCardFormModel=BusinessCardFormModel(date, employeeName.value,
          employeeMobile.value, state.employeeExt, state.employeeFaxNO, state.comment);


      try{
        var connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {

          BusinessCardRequestDataProvider(_businessCardFormModel,user)
              .getBusinessCardRequest()
              .then((value){
            emit(
              state.copyWith(
                successMessage: value.body.toString(),
                status: FormzStatus.submissionSuccess,
              ),
            );
          }).catchError((error) {
            print(error.toString());
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
      } catch(e){
        emit(
          state.copyWith(
            errorMessage: e.toString(),
            status: FormzStatus.submissionFailure,
          ),
        );

      }
    }


  }

  void nameCard(String value){
    final name = RequestDate.dirty(value);
    emit(state.copyWith(
      employeeNameCard: name,
      status: Formz.validate([name,state.employeeMobile]),
    ));
  }

  void employeeMobile(String value){
    final userMobile = RequestDate.dirty(value);
    emit(state.copyWith(
      employeeMobile: userMobile,
      status: Formz.validate([state.employeeNameCard,userMobile]),
    ));
  }

  void employeeExt(String value){
    emit(state.copyWith(
      employeeExt: value,
      status: Formz.validate([state.employeeNameCard,state.employeeMobile]),
    ));
  }

  void employeeFaxNO(String value){
    emit(state.copyWith(
      employeeFaxNO: value,
      status: Formz.validate([state.employeeNameCard,state.employeeMobile]),
    ));
  }

  void EemployeeComment(String value){
    emit(state.copyWith(
      comment: value,
      status: Formz.validate([state.employeeNameCard,state.employeeMobile]),
    ));
  }


  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
