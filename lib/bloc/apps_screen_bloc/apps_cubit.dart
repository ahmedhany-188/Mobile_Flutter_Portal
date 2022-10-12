import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/apps_model/apps_model.dart';

import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/data_providers/requests_data_providers/request_data_providers.dart';

part 'apps_state.dart';

class AppsCubit extends Cubit<AppsState> {
  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  AppsCubit(this._generalDio) : super(AppsInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state is AppsErrorState) {
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
      }
    });
  }

  static AppsCubit get(context) => BlocProvider.of(context);

  List<AppsData> appsList = [];

  void getApps() {
    emit(AppsLoadingState());
    _generalDio.appsData().then((value) {
      if (value.data != null && value.statusCode ==200) {
        AppsModel appsResponse = AppsModel.fromJson(value.data);
        if (appsResponse.data != null) {
          appsList = appsResponse.data!;
          emit(AppsSuccessState(appsList));
        } else {
          emit(AppsErrorState('noAppsFound'));
        }
      }else{
        throw RequestFailureApi(value.statusCode.toString());
      }
    }).catchError((e) {
      emit(AppsErrorState('rrrrrrrrrrrrr'));
    });
  }

  void getAllApps() {
    emit(AppsSuccessState(appsList));
  }

  void updateApps(String searchString) {
    var splitQuery = searchString.toLowerCase().trim().split(' ');
    var temp = appsList
        .where((element) => splitQuery.every(
              (singleSplitElement) => element.sysName
                  .toString()
                  .toLowerCase()
                  .trim()
                  .contains(singleSplitElement),
            ))
        .toList();

    emit(AppsSuccessState(temp));
  }
}
