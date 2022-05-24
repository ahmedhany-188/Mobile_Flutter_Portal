import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/models/response_news.dart';

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


  List<Data> newsList = [];
  List<Data> latestNewsList = [];


  void getNews() {
    emit(NewsLoadingState());

    GeneralDio.newsData().then((value) {
      ResponseNews newsResponse = ResponseNews.fromJson(value.data);
      if(newsResponse.data != null){
        newsList = newsResponse.data!;
        emit(NewsSuccessState(newsList));
      }
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

      ResponseNews newsResponse = ResponseNews.fromJson(value.data);
      if(newsResponse.data != null){
        latestNewsList = newsResponse.data!;
        // latestNewsList.add(Data(newsID: 0,newsBody: "Test",newsTitle: "Test"));
        emit(LatestNewsSuccessState(latestNewsList));
      }

    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsErrorState(error.toString()));
    });
  }

}
