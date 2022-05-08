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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userHRCode'] = this.userHRCode;
    data['email'] = this.email;
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    return data;
  }
}