part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<Data> newsList;
  final List<AnimatedText> announcment;

  NewsSuccessState(this.newsList,this.announcment);
}
class LatestNewsSuccessState extends NewsState {
  final List<Data> latestNewsList;

  LatestNewsSuccessState(this.latestNewsList);
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);
}
