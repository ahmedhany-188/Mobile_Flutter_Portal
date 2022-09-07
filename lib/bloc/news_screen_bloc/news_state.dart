part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<NewsDataModel> newsList;
  final List<AnimatedText> announcment;

  NewsSuccessState(this.newsList,this.announcment);
}
class LatestNewsSuccessState extends NewsState {
  final List<NewsData> latestNewsList;

  LatestNewsSuccessState(this.latestNewsList);
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);
}
