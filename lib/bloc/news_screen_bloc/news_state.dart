part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  List<Data> newsList;

  NewsSuccessState(this.newsList);
}
class LatestNewsSuccessState extends NewsState {
  List<Data> latestNewsList;

  LatestNewsSuccessState(this.latestNewsList);
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);
}
