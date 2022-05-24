import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final Connectivity connectivity = Connectivity();

  NewsCubit() : super(NewsInitial()){
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {

          getNews();
          getLatestNews();

        } catch (e) {
          emit(NewsErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(NewsErrorState("No internet Connection"));
      }
    });
  }

  static NewsCubit get(context) => BlocProvider.of(context);


  Map<String,dynamic> newsList = {};
  Map<String,dynamic> latestNewsList = {};


  void getNews() {
    emit(NewsLoadingState());

    GeneralDio.newsData().then((value) {
      newsList = value.data;

      emit(NewsSuccessState(newsList));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsErrorState(error.toString()));
    });
  }

  void getLatestNews() {
    emit(NewsLoadingState());

    GeneralDio.latestNewsData().then((value) {
      latestNewsList = value.data;

      // latestNewsList.addAll(other)

      emit(LatestNewsSuccessState(latestNewsList));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsErrorState(error.toString()));
    });
  }

}
