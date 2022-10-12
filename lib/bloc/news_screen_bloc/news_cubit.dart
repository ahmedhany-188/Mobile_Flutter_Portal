import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
import '../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../data/models/news_model/news_data_model.dart';
import '../../data/models/news_model/response_news.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final Connectivity connectivity = Connectivity();

  NewsCubit(this._generalDio) : super(NewsInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          getNewsOld();
          getLatestNews();
        } catch (e) {
          emit(NewsErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(NewsErrorState("No internet Connection"));
      }
    });
  }

  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);

  final GeneralDio _generalDio;

  List<NewsDataModel> newsList = [];
  List<NewsData> latestNewsList = [];
  List<AnimatedText> announcment = [];

  // void getNews() {
  //   emit(NewsLoadingState());
  //
  //   GeneralDio.newsData().then((value) {
  //     ResponseNews newsResponse = ResponseNews.fromJson(value.data);
  //     if (newsResponse.data != null) {
  //       newsList = newsResponse.data!;
  //       for (int i = 0; i < newsList.length - 1; i++) {
  //         if (newsList[i].newsType == 1) {
  //           announcment.add(
  //             TyperAnimatedText(
  //               newsList[i].newsDescription!,
  //               speed: const Duration(milliseconds: 50),
  //               textAlign: TextAlign.center,
  //               curve: Curves.linear,
  //               textStyle: const TextStyle(
  //                   color: Colors.white,
  //                   overflow: TextOverflow.visible,
  //                   fontFamily: 'RobotoFlex',
  //                   fontSize: 14),
  //             ),
  //           );
  //         }
  //       }
  //
  //       emit(NewsSuccessState(newsList,announcment));
  //     }
  //   }).catchError((error) {
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //     emit(NewsErrorState(error.toString()));
  //   });
  // }

  void getNewsOld() {
    emit(NewsLoadingState());
    _generalDio.newsDataOld().then((value) {
      if (value.data != null && value.statusCode == 200) {
        List<NewsDataModel> newsDataList = List<NewsDataModel>.from(
            value.data.map((model) => NewsDataModel.fromJson(model)));
        newsList = newsDataList.reversed.toList();
        emit(NewsSuccessState(newsDataList, announcment));
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    });
    _generalDio.newsDataOld(type: 1).then((value) {
      if (value.data != null && value.statusCode == 200) {
        List<NewsDataModel> newsDataListAnnouncment = List<NewsDataModel>.from(
            value.data.map((model) => NewsDataModel.fromJson(model)));
        for (int i = 0; i < newsDataListAnnouncment.length; i++) {
          if (newsDataListAnnouncment[i].newsType == 1) {
            announcment.add(
              TyperAnimatedText(
                newsDataListAnnouncment[i].newsDescription ?? '',
                speed: const Duration(milliseconds: 50),
                textAlign: TextAlign.center,
                curve: Curves.linear,
                textStyle: const TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.visible,
                    fontFamily: 'RobotoFlex',
                    fontSize: 14),
              ),
            );
          }
        }
      } else {
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    });
  }

  void getLatestNews() {
    emit(NewsLoadingState());

    _generalDio.latestNewsData().then((value) {
      ResponseNews newsResponse = ResponseNews.fromJson(value.data);
      if (newsResponse.data != null && value.statusCode == 200) {
        latestNewsList = newsResponse.data!;
        emit(LatestNewsSuccessState(latestNewsList));
      }else{
        throw RequestFailureApi.fromCode(value.statusCode!);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsErrorState(error.toString()));
    });
  }
}
