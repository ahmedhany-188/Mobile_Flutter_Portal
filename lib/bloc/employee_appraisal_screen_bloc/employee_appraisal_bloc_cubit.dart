import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/appraisal_models/employee_appraisal_model.dart';
import 'package:hassanallamportalflutter/data/repositories/employee_appraisal_repository.dart';
import 'package:meta/meta.dart';

part 'employee_appraisal_bloc_state.dart';

class EmployeeAppraisalBlocCubit extends Cubit<EmployeeAppraisalBlocState> {
  EmployeeAppraisalBlocCubit(this.employeeAppraisalRepository) : super(EmployeeAppraisalBlocInitial());

  final EmployeeAppraisalRepository employeeAppraisalRepository;

  static EmployeeAppraisalBlocCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  void getEmployeeAppraisalList(String hrCode) async {
    emit(BlocGetEmployeeAppraisalBlocInitialLoadingState());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        // EmployeeAppraisaleDataProvider().getEmployeeApraisalList(hrCode).then((value) {
        employeeAppraisalRepository.getAppraisalData(hrCode).then((value) {
          emit(BlocGetEmployeeAppraisalBlocInitialSuccessState(value));
        }).catchError((error) {
          emit(BlocGetEmployeeAppraisalBlocInitialErrorState(error.toString()));
        });
      } else {
        emit(BlocGetEmployeeAppraisalBlocInitialErrorState(
            "No internet connection"));
      }
    } catch (e) {
      emit(BlocGetEmployeeAppraisalBlocInitialErrorState(e));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
