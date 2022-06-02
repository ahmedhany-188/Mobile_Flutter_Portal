class PhotosModel {
  int? code;
  bool? error;
  String? message;
  List<PhotosIdData>? data;

  PhotosModel({this.code, this.error, this.message, this.data});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PhotosIdData>[];
      json['data'].forEach((v) {
        data!.add(PhotosIdData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotosIdData {
  int? id;
  String? albumName;
  String? albumDesc;
  String? inUser;
  String? inDate;

  PhotosIdData({this.id, this.albumName, this.albumDesc, this.inUser, this.inDate});

  PhotosIdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumName = json['album_name'];
    albumDesc = json['album_Desc'];
    inUser = json['in_user'];
    inDate = json['in_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['album_name'] = albumName;
    data['album_Desc'] = albumDesc;
    data['in_user'] = inUser;
    data['in_date'] = inDate;
    return data;
  }
}