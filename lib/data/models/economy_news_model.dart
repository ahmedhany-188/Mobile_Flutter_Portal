
class Economynews_Model{

  String? author;
  String? title;
  bool? description;
  int? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Economynews_Model(this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);


  Economynews_Model.fromJson(Map<String, dynamic> json) {
    author=json['author'];
    title=json['title'];
    description=json['description'];
    url=json['url'];
    urlToImage=json['urlToImage'];
    publishedAt=json['publishedAt'];
    content=json['content'];
  }

}