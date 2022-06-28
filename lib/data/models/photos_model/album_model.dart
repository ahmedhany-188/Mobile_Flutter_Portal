class AlbumModel {
  int? code;
  bool? error;
  String? message;
  List<AlbumData>? data;

  AlbumModel({this.code, this.error, this.message, this.data});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AlbumData>[];
      json['data'].forEach((v) {
        data!.add(AlbumData.fromJson(v));
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

class AlbumData {
  int? id;
  int? albumID;
  String? photoName;
  String? photoDesc;
  String? inUser;
  String? inDate;

  AlbumData(
      {this.id,
      this.albumID,
      this.photoName,
      this.photoDesc,
      this.inUser,
      this.inDate});

  AlbumData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumID = json['album_ID'];
    photoName = json['photo_name'];
    photoDesc = json['photo_Desc'];
    inUser = json['in_user'];
    inDate = json['in_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['album_ID'] = albumID;
    data['photo_name'] = photoName;
    data['photo_Desc'] = photoDesc;
    data['in_user'] = inUser;
    data['in_date'] = inDate;
    return data;
  }
}
