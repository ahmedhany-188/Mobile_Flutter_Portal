import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';

part 'benefits_state.dart';

class BenefitsCubit extends Cubit<BenefitsState> {
  BenefitsCubit() : super(BenefitsInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state is BenefitsErrorState) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getBenefits();
          } catch (e) {
            emit(BenefitsErrorState(e.toString()));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(BenefitsErrorState("No internet Connection"));
        }
      }
    });
  }

  static BenefitsCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();

  List<dynamic> benefits = [];

  void getBenefits() {
    emit(BenefitsLoadingState());

    GeneralDio.getBenefitsData().then((value) {
      benefits = value.data;
      emit(BenefitsSuccessState(benefits));
    }).catchError((error) {
      print(error.toString());
      emit(BenefitsErrorState(error.toString()));
    });
  }
}
