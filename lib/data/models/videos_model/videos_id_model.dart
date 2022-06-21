class VideosIdModel {
  int? code;
  bool? error;
  String? message;
  List<VideosIdData>? data;

  VideosIdModel({this.code, this.error, this.message, this.data});

  VideosIdModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VideosIdData>[];
      json['data'].forEach((v) {
        data!.add(VideosIdData.fromJson(v));
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

class VideosIdData {
  int? id;
  String? videoName;
  bool? isMain;
  bool? isPortal;
  bool? isSefty;
  bool? isScreen;
  bool? isIT;
  String? inUser;
  String? inDate;

  VideosIdData(
      {this.id,
        this.videoName,
        this.isMain,
        this.isPortal,
        this.isSefty,
        this.isScreen,
        this.isIT,
        this.inUser,
        this.inDate});

  VideosIdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoName = json['videoName'];
    isMain = json['isMain'];
    isPortal = json['isPortal'];
    isSefty = json['isSefty'];
    isScreen = json['isScreen'];
    isIT = json['isIT'];
    inUser = json['in_User'];
    inDate = json['in_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videoName'] = videoName;
    data['isMain'] = isMain;
    data['isPortal'] = isPortal;
    data['isSefty'] = isSefty;
    data['isScreen'] = isScreen;
    data['isIT'] = isIT;
    data['in_User'] = inUser;
    data['in_Date'] = inDate;
    return data;
  }
}