import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/employee_appraisal_data_provider/employee_appraisal_data_provider.dart';
import 'package:meta/meta.dart';

part 'employee_appraisal_bloc_state.dart';

class EmployeeAppraisalBlocCubit extends Cubit<EmployeeAppraisalBlocState> {
  EmployeeAppraisalBlocCubit() : super(EmployeeAppraisalBlocInitial());


  static EmployeeAppraisalBlocCubit get(context) => BlocProvider.of(context) ;



  void getEmployeeAppraisalList(String hrCode) async{


    emit(BlocgetEmployeeAppraisalBlocInitialLoadingState());

    EmployeeAppraisaleDataProvider(hrCode).getEmployeeApraisalList().then((value){

      print("----,."+value.body);

      emit(BlocgetEmployeeAppraisalBlocInitialSuccessState(value.body));

    }).catchError((error){
      print(error.toString());
      emit(BlocgetEmployeeAppraisalBlocInitialErrorState(error.toString()));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
