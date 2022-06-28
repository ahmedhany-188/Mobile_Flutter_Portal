
class EconomyNewsModel {

  String? author;
  String? title;
  bool? description;
  int? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  EconomyNewsModel(this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);


  EconomyNewsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

}