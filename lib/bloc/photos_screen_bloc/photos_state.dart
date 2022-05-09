part of 'photos_cubit.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class PhotosLoadingState extends PhotosState {}

class PhotosSuccessState extends PhotosState {
  Map<String,dynamic> photosList;

  PhotosSuccessState(this.photosList);
}

class PhotosErrorState extends PhotosState {
  final String error;
  PhotosErrorState(this.error);
}


class AlbumSuccessState extends PhotosState {
  Map<String,dynamic> albumList;

  AlbumSuccessState(this.albumList);
}
