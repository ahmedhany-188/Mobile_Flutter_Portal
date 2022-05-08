import 'dart:convert';

import 'package:hassanallamportalflutter/data/data_providers/authentication_data_provider/authentication_api_provider.dart';
import 'package:hassanallamportalflutter/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositorytesting {
  late final AuthenticationApiProvider authenticationApiProvider;

  Future<User> getAuthenticationApi({required String userName,required String password}) async {
    final http.Response rawUser = await authenticationApiProvider.loginApiAuthentication(userName, password);
    final json = await jsonDecode(rawUser.body);
    final User user = User.fromJson(json);
    return user;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain

    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

}