import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/attendance_data_provider/attendance_data_provider.dart';
import 'package:hassanallamportalflutter/data/data_providers/medical_request_data_provider/medical_request_data_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'medical_request_state.dart';

class MedicalRequestCubit extends Cubit<MedicalRequestState> {
  MedicalRequestCubit() : super(MedicalRequestInitial());

  static MedicalRequestCubit get(context) => BlocProvider.of(context);


  void getSuccessMessage(String HR_code,String HAHuser_MedicalRequest,String Patientname_MedicalRequest, String selectedValueLab,String selectedValueService,String selectedDate) async {
    emit(BlocGetTheMedicalRequestLoadingState());

    MedicalRequestDataProvider(HR_code,HAHuser_MedicalRequest,Patientname_MedicalRequest,selectedValueLab,selectedValueService,selectedDate).getMedicalRequestMessage().then((value) {
      emit(BlocgetTheMedicalRequestSuccesState(value.body));
      // print("------------------------------"+value.body);

    }).catchError((error) {
      print(error.toString());
      emit(BlocgetTheMedicalRequestErrorState(error.toString()));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }

}
