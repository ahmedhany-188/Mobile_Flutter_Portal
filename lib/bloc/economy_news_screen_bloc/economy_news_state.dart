part of 'economy_news_cubit.dart';

@immutable
abstract class EconomyNewsState {}

class EconomyNewsInitial extends EconomyNewsState {}


class BlocGetTheEconomyNewsLoadingState extends EconomyNewsState{}

class BlocGetTheEconomyNewsSuccesState extends EconomyNewsState{

  String EconomyNewsList;

  BlocGetTheEconomyNewsSuccesState(this.EconomyNewsList);

}

class BlocGetTheEconomyNewsErrorState extends EconomyNewsState{

   final String error;
   BlocGetTheEconomyNewsErrorState(this.error);

}



