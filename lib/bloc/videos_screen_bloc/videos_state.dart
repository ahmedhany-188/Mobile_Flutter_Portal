part of 'videos_cubit.dart';

@immutable
abstract class VideosState {}

class VideosInitial extends VideosState {}

class VideosLoadingState extends VideosState {}

class VideosSuccessState extends VideosState {
  Map<String,dynamic> videosList;

  VideosSuccessState(this.videosList);
}

class VideosErrorState extends VideosState {
  final String error;
  VideosErrorState(this.error);
}

