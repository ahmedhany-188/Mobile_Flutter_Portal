import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/apps_model/apps_model.dart';

import '../../data/data_providers/general_dio/general_dio.dart';

part 'apps_state.dart';

class AppsCubit extends Cubit<AppsState> {
  final Connectivity connectivity = Connectivity();

  AppsCubit() : super(AppsInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          getApps();
        } catch (e) {
          emit(AppsErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(AppsErrorState("No internet Connection"));
      }
    });
  }

  static AppsCubit get(context) => BlocProvider.of(context);

  List<AppsData> appsList = [];

  void getApps({String? hrCode}) {
    emit(AppsLoadingState());

    GeneralDio.appsData(hrCode).then((value) {
      if(value.statusCode == 400){
        emit(AppsErrorState('400'));
      }
      if (value.data != null) {
        AppsModel appsResponse = AppsModel.fromJson(value.data);
        if (appsResponse.data != null) {
          appsList = appsResponse.data!;
          emit(AppsSuccessState(appsList));
        }
      }
    }).timeout(Duration(minutes: 1)).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppsErrorState(error.toString()));
    });
  }
}
