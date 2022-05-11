import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_providers/album_dio/album_dio.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  final Connectivity connectivity = Connectivity();

  VideosCubit() : super(VideosInitial()) {
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

  Map<String, dynamic> videosList = {};

  void getVideos() {
    emit(VideosLoadingState());

    AlbumDio.getVideos().then((value) {
      videosList = value.data;

      emit(VideosSuccessState(videosList));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(VideosErrorState(error.toString()));
    });
  }
}
