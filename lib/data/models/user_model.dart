class User {
  String? userHRCode;
  String? email;
  String? token;
  String? expiration;

  User({this.userHRCode, this.email, this.token, this.expiration});

  User.fromJson(Map<String, dynamic> json) {
    userHRCode = json['userHRCode'];
    email = json['email'];
    token = json['token'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userHRCode'] = userHRCode;
    data['email'] = email;
    data['token'] = token;
    data['expiration'] = expiration;
    return data;
  }
}