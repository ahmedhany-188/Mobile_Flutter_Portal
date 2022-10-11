import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../data/models/subsidiares_model/subsidiares_model.dart';

part 'subsidiaries_state.dart';

class SubsidiariesCubit extends Cubit<SubsidiariesState> {
  final Connectivity connectivity = Connectivity();
  GeneralDio _generalDio;

  SubsidiariesCubit(this._generalDio) : super(SubsidiariesInitial()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {

          getSubsidiaries();

        } catch (e) {
          emit(SubsidiariesErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(SubsidiariesErrorState("No internet Connection"));
      }
    });
  }

  static SubsidiariesCubit get(context) => BlocProvider.of(context);


  List<SubsidiariesData> subsidiariesList = [];

  void getSubsidiaries() {
    emit(SubsidiariesLoadingState());

    _generalDio.subsidiariesData().then((value) {
      if (value.data != null && value.statusCode ==200) {
        SubsidiariesModel subsidiariesResponse = SubsidiariesModel.fromJson(value.data);
        if (subsidiariesResponse.data != null) {
          subsidiariesList = subsidiariesResponse.data!;
          emit(SubsidiariesSuccessState(subsidiariesList));
        }
      }else{
        throw RequestFailureApi(value.statusCode.toString());
      }


    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SubsidiariesErrorState(error.toString()));
    });
  }


}
