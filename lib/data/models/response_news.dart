class ResponseNews {
  int? code;
  bool? error;
  String? message;
  List<Data>? data;

  ResponseNews({this.code, this.error, this.message, this.data});

  ResponseNews.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? newsID;
  String? newsDescription;
  String? newsBody;
  String? newsTitleAr;
  String? newsBodyAr;
  String? newsDate;
  String? newsTitle;
  int? fIndex;
  int? ftype;
  bool? active;
  int? noOfDays;
  int? newsType;
  String? newsImg;

  Data(
      {this.newsID,
        this.newsDescription,
        this.newsBody,
        this.newsTitleAr,
        this.newsBodyAr,
        this.newsDate,
        this.newsTitle,
        this.fIndex,
        this.ftype,
        this.active,
        this.noOfDays,
        this.newsType,
        this.newsImg});

  Data.fromJson(Map<String, dynamic> json) {
    newsID = json['news_ID'];
    newsDescription = json['news_Description'];
    newsBody = json['news_Body'];
    newsTitleAr = json['news_Title_ar'];
    newsBodyAr = json['news_Body_ar'];
    newsDate = json['news_Date'];
    newsTitle = json['news_Title'];
    fIndex = json['fIndex'];
    ftype = json['ftype'];
    active = json['active'];
    noOfDays = json['noOfDays'];
    newsType = json['news_type'];
    newsImg = json['news_Img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_ID'] = this.newsID;
    data['news_Description'] = this.newsDescription;
    data['news_Body'] = this.newsBody;
    data['news_Title_ar'] = this.newsTitleAr;
    data['news_Body_ar'] = this.newsBodyAr;
    data['news_Date'] = this.newsDate;
    data['news_Title'] = this.newsTitle;
    data['fIndex'] = this.fIndex;
    data['ftype'] = this.ftype;
    data['active'] = this.active;
    data['noOfDays'] = this.noOfDays;
    data['news_type'] = this.newsType;
    data['news_Img'] = this.newsImg;
    return data;
  }
}