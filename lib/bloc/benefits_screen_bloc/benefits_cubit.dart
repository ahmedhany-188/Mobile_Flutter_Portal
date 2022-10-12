import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/data_providers/requests_data_providers/request_data_providers.dart';

part 'benefits_state.dart';

class BenefitsCubit extends Cubit<BenefitsState> {
  BenefitsCubit(this._generalDio) : super(BenefitsInitial()) {
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
  final GeneralDio _generalDio;

  void getBenefits() {
    emit(BenefitsLoadingState());

    _generalDio.getBenefitsData().then((value) {
      if (value.data != null && value.statusCode == 200) {
        benefits = value.data;
        emit(BenefitsSuccessState(benefits));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(BenefitsErrorState(error.toString()));
    });
  }
}
