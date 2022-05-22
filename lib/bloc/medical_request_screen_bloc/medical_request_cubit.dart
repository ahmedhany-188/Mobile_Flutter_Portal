import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/data_providers/medical_request_data_provider/medical_request_data_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'medical_request_state.dart';

class MedicalRequestCubit extends Cubit<MedicalRequestState> {
  MedicalRequestCubit() : super(MedicalRequestInitial());

  final Connectivity connectivity = Connectivity();

  static MedicalRequestCubit get(context) => BlocProvider.of(context);

  void getSuccessMessage(String HR_code,String HAHuser_MedicalRequest,String Patientname_MedicalRequest,
      String selectedValueLab,String selectedValueService,String selectedDate) async {
    emit(BlocGetTheMedicalRequestLoadingState());

    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

        // final response = await MedicalRequestDataProvider(HR_code,HAHuser_MedicalRequest,Patientname_MedicalRequest,
        //     selectedValueLab,selectedValueService,selectedDate).getMedicalRequestMessage();

        MedicalRequestDataProvider(HR_code,HAHuser_MedicalRequest,Patientname_MedicalRequest,
            selectedValueLab,selectedValueService,selectedDate).getMedicalRequestMessage().then((value) {
          emit(BlocgetTheMedicalRequestSuccesState("Success"));
        }).catchError((error) {
          print(error.toString());
          emit(BlocgetTheMedicalRequestErrorState(error.toString()));
        });
      }else{
        emit(BlocgetTheMedicalRequestErrorState("No internet Connection"));
      }
    }
    catch(e){
      emit(BlocgetTheMedicalRequestErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
