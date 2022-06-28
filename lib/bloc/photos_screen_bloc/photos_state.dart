part of 'photos_cubit.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class PhotosLoadingState extends PhotosState {}

class PhotosSuccessState extends PhotosState {
  List<PhotosIdData> photosList;

  PhotosSuccessState(this.photosList);
}

class PhotosErrorState extends PhotosState {
  final String error;
  PhotosErrorState(this.error);
}


class AlbumSuccessState extends PhotosState {
  List<AlbumData> albumList;

  AlbumSuccessState(this.albumList);
}
