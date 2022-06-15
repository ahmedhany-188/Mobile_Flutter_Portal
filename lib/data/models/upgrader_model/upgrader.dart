class Upgrader {
  final Android? android;
  final Android? ios;

  static const Upgrader empty =  Upgrader(android: Android.empty,ios: Android.empty);

  const Upgrader({this.android, this.ios});

  Upgrader.fromJson(Map<String, dynamic> json) : android =
  json['android'] != null ? Android.fromJson(json['android']) : null,
  ios = json['ios'] != null ? Android.fromJson(json['ios']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (android != null) {
      data['android'] = android!.toJson();
    }
    if (ios != null) {
      data['ios'] = ios!.toJson();
    }
    return data;
  }
}

class Android {
  final String? version;
  final String? link;
  final bool? force;
  final String? message;

  const Android({this.version, this.link, this.force, this.message});
  static const Android empty =  Android(force: false,link: "",message: "",version: "");

  Android.fromJson(Map<String, dynamic> json):version = json['version'],
  link = json['link'],
  force = json['force'],
  message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['link'] = this.link;
    data['force'] = this.force;
    data['message'] = this.message;
    return data;
  }
}