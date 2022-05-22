import 'package:hassanallamportalflutter/data/data_providers/album_dio/album_dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  final Connectivity connectivity = Connectivity();

  PhotosCubit() : super(PhotosInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          getPhotos();
        } catch (e) {
          emit(PhotosErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(PhotosErrorState("No internet Connection"));
      }
    });
  }

  static PhotosCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> photosList = {};
  Map<String, dynamic> albumList = {};

  void getPhotos() {
    emit(PhotosLoadingState());

    AlbumDio.getPhotosAlbumsId().then((value) {
      photosList = value.data;

      emit(PhotosSuccessState(photosList));

    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(PhotosErrorState(error.toString()));
    });
  }

  void getAlbum(String id) {
    emit(PhotosLoadingState());

    AlbumDio.getPhotosAlbums(id: id).then((value) {
      albumList = value.data;

      emit(AlbumSuccessState(albumList));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(PhotosErrorState(error.toString()));
    });
  }



}
