import 'package:equatable/equatable.dart';


class PermissionRequest extends Equatable {

  final String? requestDate;
  final String? permissionDate;
  final String? requestType;
  final String? requestTime;

  const PermissionRequest({required this.requestDate, this.permissionDate, this.requestType, this.requestTime});


  // User.fromJson(Map<String, dynamic> json) {
  //   // return User(email: json['email'],userHRCode: json['userHRCode'],token: json['token'],expiration: json['expiration']);
  //   userHRCode = json['userHRCode'];
  //   email = json['email'];
  //   token = json['token'];
  //   expiration = json['expiration'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['userHRCode'] = this.userHRCode;
  //   data['email'] = this.email;
  //   data['token'] = this.token;
  //   data['expiration'] = this.expiration;
  //   return data;
  // }

  /// Empty user which represents an unauthenticated user.
  static  const PermissionRequest empty = PermissionRequest(requestDate: 'Ahmed');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == PermissionRequest.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != PermissionRequest.empty;

  @override
  List<Object?> get props => [requestDate, requestTime, requestType];
}