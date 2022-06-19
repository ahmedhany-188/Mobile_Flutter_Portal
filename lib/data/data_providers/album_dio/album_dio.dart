import 'package:dio/dio.dart';

class AlbumDio {
  static Dio? dio;

  static initAlbums() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/portal/',
        // receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getPhotosAlbumsId(
      {String url = 'MainAlbums/GetAll'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> getPhotosAlbums({required String id}) async {
    String url = 'Main_Albums_Det/GetAll?ID=$id';
    return await dio!.get(
      url,
    );
  }

  static Future<Response> getVideos(
      {String url = 'Portal_Videos/GetVideosType'}) async {
    return await dio!.get(
      url,
    );
  }

  static Future<Response> getSingleVideo({required String id}) async {
    String url = 'portal/Portal_Videos/GetByID?ID=$id';
    return await dio!.get(
      url,
    );
  }


}
