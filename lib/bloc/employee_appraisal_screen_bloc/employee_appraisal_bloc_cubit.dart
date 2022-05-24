import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/data_providers/employee_appraisal_data_provider/employee_appraisal_data_provider.dart';
import 'package:meta/meta.dart';

part 'employee_appraisal_bloc_state.dart';

class EmployeeAppraisalBlocCubit extends Cubit<EmployeeAppraisalBlocState> {
  EmployeeAppraisalBlocCubit() : super(EmployeeAppraisalBlocInitial());


  static EmployeeAppraisalBlocCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  void getEmployeeAppraisalList(String hrCode) async {
    emit(BlocgetEmployeeAppraisalBlocInitialLoadingState());

    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        EmployeeAppraisaleDataProvider(hrCode).getEmployeeApraisalList().then((value) {
          emit(BlocgetEmployeeAppraisalBlocInitialSuccessState(value.body));
        }).catchError((error) {
          emit(BlocgetEmployeeAppraisalBlocInitialErrorState(error.toString()));
        });
      } else {
        emit(BlocgetEmployeeAppraisalBlocInitialErrorState(
            "No internet connection"));
      }
    } catch (e) {
      emit(BlocgetEmployeeAppraisalBlocInitialErrorState(e));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
