import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_providers/album_dio/album_dio.dart';
import '../../data/models/videos_model/videos_id_model.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  final Connectivity connectivity = Connectivity();

  VideosCubit(this._albumDio) : super(VideosInitial()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          getVideos();
        } catch (e) {
          emit(VideosErrorState(e.toString()));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(VideosErrorState("No internet Connection"));
      }
    });
  }

  static VideosCubit get(context) => BlocProvider.of(context);

  List<VideosIdData> videosList = [];
  AlbumDio _albumDio;


  void getVideos() {
    emit(VideosLoadingState());

    _albumDio.getVideos().then((value) {
      VideosIdModel videosResponse = VideosIdModel.fromJson(value.data);
      if (videosResponse.data!.isNotEmpty) {
        videosList = videosResponse.data!;
        emit(VideosSuccessState(videosList));
      } else {
        emit(VideosErrorState('noVideosFound'));
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(VideosErrorState(error.toString()));
    });
  }
}
