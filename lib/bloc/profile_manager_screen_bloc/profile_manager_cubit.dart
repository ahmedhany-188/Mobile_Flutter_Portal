import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/repositories/employee_repository.dart';
import 'package:meta/meta.dart';

part 'profile_manager_state.dart';

class ProfileManagerCubit extends Cubit<ProfileManagerState> {
  ProfileManagerCubit() : super(ProfileManagerInitial());


  final Connectivity connectivity = Connectivity();

  static ProfileManagerCubit get(context) => BlocProvider.of(context);


  void getManagerData(String managerHRCode) async {
    emit(BlocGetManagerDataLoadingState());

    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        GetEmployeeRepository().getEmployeeData(managerHRCode)
            .then((value){
          emit(BlocGetManagerDataSuccessState(value));
        }).catchError((error){
          print("Err0r: "+error.toString());
          emit(BlocGetManagerDataErrorState(error.toString()));
        });
      }
      else {
        emit(BlocGetManagerDataErrorState("No internet connection"));
      }
    } catch (e) {
      print("Err0r2: " + e.toString());
      emit(BlocGetManagerDataErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
