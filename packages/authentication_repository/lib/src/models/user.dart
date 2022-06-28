import 'package:equatable/equatable.dart';


class User extends Equatable {

    final String? userHRCode;
    final String email;
    final String? token;
    final String? expiration;

   const User({this.userHRCode, required this.email, this.token, this.expiration});


  User.fromJson(Map<String, dynamic> json):
    userHRCode = json['userHRCode'],
    email = json['email'],
    token = json['token'],
    expiration = json['expiration'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userHRCode'] = this.userHRCode;
    data['email'] = this.email;
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    return data;
  }

  /// Empty user which represents an unauthenticated user.
  static  const User empty = User(email: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, userHRCode, token, expiration];
}