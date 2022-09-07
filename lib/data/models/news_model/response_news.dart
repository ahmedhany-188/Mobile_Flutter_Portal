class ResponseNews {
  int? code;
  bool? error;
  String? message;
  List<NewsData>? data;

  ResponseNews({this.code, this.error, this.message, this.data});

  ResponseNews.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NewsData>[];
      json['data'].forEach((v) {
        data!.add(NewsData.fromJson(v));
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

class NewsData {
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

  NewsData(
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

  NewsData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['news_ID'] = newsID;
    data['news_Description'] = newsDescription;
    data['news_Body'] = newsBody;
    data['news_Title_ar'] = newsTitleAr;
    data['news_Body_ar'] = newsBodyAr;
    data['news_Date'] = newsDate;
    data['news_Title'] = newsTitle;
    data['fIndex'] = fIndex;
    data['ftype'] = ftype;
    data['active'] = active;
    data['noOfDays'] = noOfDays;
    data['news_type'] = newsType;
    data['news_Img'] = newsImg;
    return data;
  }
}