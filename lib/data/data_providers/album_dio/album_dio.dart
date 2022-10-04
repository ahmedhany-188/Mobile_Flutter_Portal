import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';

class AlbumDio {
  static Dio? dio;
  MainUserData? userData;

  // GeneralDio(this.userData);

  static final AlbumDio _inst = AlbumDio._internal();

  AlbumDio._internal();

  factory AlbumDio(MainUserData userData) {
    _inst.userData = userData;
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.hassanallam.com/api/portal/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${userData.user?.token}',
        },
        // receiveDataWhenStatusError: true,
      ),
    );
    return _inst;
  }

  Future<Response> getPhotosAlbumsId(
      {String url = 'MainAlbums/GetAll'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getPhotosAlbums({required String id}) async {
    String url = 'Main_Albums_Det/GetAll?ID=$id';
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getVideos(
      {String url = 'Portal_Videos/GetVideosType'}) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }

  Future<Response> getSingleVideo({required String id}) async {
    String url = 'portal/Portal_Videos/GetByID?ID=$id';
    return await dio!.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer ${userData?.user?.token}'},
      ),
    );
  }


}
