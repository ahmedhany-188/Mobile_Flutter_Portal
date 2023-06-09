import 'package:hassanallamportalflutter/data/data_providers/album_dio/album_dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/photos_model/album_model.dart';

import '../../data/data_providers/requests_data_providers/request_data_providers.dart';
import '../../data/models/photos_model/photos_model.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  final Connectivity connectivity = Connectivity();

  PhotosCubit(this._albumDio) : super(PhotosInitial()) {
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

  List<PhotosIdData> photosList = [];
  List<AlbumData> albumList = [];
  final AlbumDio _albumDio;

  void getPhotos() {
    emit(PhotosLoadingState());

    _albumDio.getPhotosAlbumsId().then((value) {
      if(value.data != null && value.statusCode == 200){
        PhotosModel photosResponse = PhotosModel.fromJson(value.data);
        if (photosResponse.data != null) {
          photosList = photosResponse.data!;
          emit(PhotosSuccessState(photosList));
        }
      }else{
        throw RequestFailureApi(value.statusCode.toString());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(PhotosErrorState(error.toString()));
    });
  }

  void getAlbum(String id) {
    emit(PhotosLoadingState());

    _albumDio.getPhotosAlbums(id: id).then((value) {
      if(value.data != null && value.statusCode == 200){
        AlbumModel albumResponse = AlbumModel.fromJson(value.data);
        if (albumResponse.data != null) {
          albumList = albumResponse.data!;
          emit(AlbumSuccessState(albumList));
        }
      }else{
        throw RequestFailureApi(value.statusCode.toString());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(PhotosErrorState(error.toString()));
    });
  }
}
