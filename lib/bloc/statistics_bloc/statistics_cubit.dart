import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../data/models/statistics_model/statistics_model.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsInitial> {
  StatisticsCubit(this._generalDio) : super(const StatisticsInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (state.statisticsStates == StatisticsEnumStates.failed) {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          try {
            getStatistics();
          } catch (e) {
            emit(state.copyWith(
              statisticsStates: StatisticsEnumStates.failed,
            ));
          }
        } else if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            statisticsStates: StatisticsEnumStates.failed,
          ));
        }
      }
    });
  }

  final Connectivity connectivity = Connectivity();
  final GeneralDio _generalDio;

  static StatisticsCubit get(context) => BlocProvider.of(context);

  void getStatistics() {
    emit(state.copyWith(
      statisticsStates: StatisticsEnumStates.initial,
    ));
    _generalDio.getStatistics().then((value) {
      if (value.data != null && value.statusCode == 200) {
        List<Statistics> statisticsList = List<Statistics>.from(
            value.data.map((model) => Statistics.fromJson(model)));

        emit(state.copyWith(
            statisticsList: statisticsList,
            statisticsStates: StatisticsEnumStates.success));
      } else {
        emit(state.copyWith(statisticsStates: StatisticsEnumStates.failed));
        throw RequestFailureApi(value.statusCode.toString());
      }
    }).catchError((e) {
      emit(state.copyWith(statisticsStates: StatisticsEnumStates.failed));
    });
  }
}
