part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  Map<String,dynamic> newsList;

  NewsSuccessState(this.newsList);
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);
}
