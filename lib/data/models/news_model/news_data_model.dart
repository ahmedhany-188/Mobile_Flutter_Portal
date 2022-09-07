class NewsDataModel {
  int? newsId;
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

  NewsDataModel(
      {this.newsId,
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
        this.newsType});

  NewsDataModel.fromJson(Map<String, dynamic> json) {
    newsId = json['newsId'];
    newsDescription = json['newsDescription'];
    newsBody = json['newsBody'];
    newsTitleAr = json['newsTitleAr'];
    newsBodyAr = json['newsBodyAr'];
    newsDate = json['newsDate'];
    newsTitle = json['newsTitle'];
    fIndex = json['fIndex'];
    ftype = json['ftype'];
    active = json['active'];
    noOfDays = json['noOfDays'];
    newsType = json['newsType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newsId'] = newsId;
    data['newsDescription'] = newsDescription;
    data['newsBody'] = newsBody;
    data['newsTitleAr'] = newsTitleAr;
    data['newsBodyAr'] = newsBodyAr;
    data['newsDate'] = newsDate;
    data['newsTitle'] = newsTitle;
    data['fIndex'] = fIndex;
    data['ftype'] = ftype;
    data['active'] = active;
    data['noOfDays'] = noOfDays;
    data['newsType'] = newsType;
    return data;
  }
}