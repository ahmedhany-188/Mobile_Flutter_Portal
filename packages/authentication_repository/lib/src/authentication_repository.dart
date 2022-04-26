import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/src/authentication_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication_repository.dart';
import 'cashe.dart';

enum AuthenticationStatus {authenticated, unauthenticated}
class AuthenticationRepository {
  late final AuthenticationProvider authenticationProvider = AuthenticationProvider();
  final _controller = StreamController<User>();
  static const userCacheKey = '__user_cache_key__';
  final CacheClient _cache = CacheClient();
  late SharedPreferences shared_User;
  Future<void> init() async {
    shared_User = await SharedPreferences.getInstance();
  }



  Stream<User> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    try{
      String? data = shared_User.getString('user');

      Map userMap = jsonDecode(data!);
      var user = getFromJson(userMap as Map<String, dynamic>);
      yield user;
    }catch(e){
      yield User.empty;
    }


    // yield _cache.read<User>(key: userCacheKey) ?? User.empty;;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    //  authentication provider to api functions
    // authenticationProvider = AuthenticationProvider();
    // var box = await Hive.openBox('myBox');
    await authenticationProvider.loginApiAuthentication(username, password)
        .then(
            (value) async {
          if (value.statusCode == 200) {
            final json = await jsonDecode(value.body);
            try {
              User user = getFromJson(json[0]);
              String userData = jsonEncode(json[0]);
              shared_User.setString('user', userData);
              _controller.add(user);
            } catch (e) {
              print(e);
            }
          } else {
            throw LogInWithEmailAndPasswordFailureApi.fromCode(
                value.statusCode);
          }
        });
  }

  User getFromJson(Map<String, dynamic> json) {
    return User(email: json['email'],
        userHRCode: json['userHRCode'],
        token: json['token'],
        expiration: json['expiration']);
  }

  Future<void> logOut() async {
    try {
      _controller.add(User.empty);
      // add all functions to log out from user
      await Future.wait([
        shared_User.remove('user'),
        shared_User.clear()
        // _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      // throw LogOutFailure();
    }
  }

  User get currentUser  {
    try{
      String? data = shared_User.getString('user');

      Map userMap = jsonDecode(data!);
      var user = getFromJson(userMap as Map<String, dynamic>);
      return user;
    }catch(e){
      return User.empty;
    }
  }

  Stream<User> get user async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    var user = _cache.read<User>(key: userCacheKey) ?? User.empty;
    yield user;
  }

  void dispose() => _controller.close();
}
class SignUpWithEmailAndPasswordFailureFirebase implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailureFirebase([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailureFirebase.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailureFirebase(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailureFirebase(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailureFirebase(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailureFirebase(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailureFirebase(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailureFirebase();
    }
  }

  /// The associated error message.
  final String message;
}
class LogInWithEmailAndPasswordFailureFirebase implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailureFirebase([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailureFirebase.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailureFirebase(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailureFirebase(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailureFirebase(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailureFirebase(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailureFirebase();
    }
  }

  /// The associated error message.
  final String message;
}
class LogInWithEmailAndPasswordFailureApi implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailureApi([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailureApi.fromCode(int code) {
    switch (code) {
      case 404:
        return const LogInWithEmailAndPasswordFailureApi(
          "Username or password are wrong",
        );

      default:
        return const LogInWithEmailAndPasswordFailureApi();
    }
  }

  /// The associated error message.
  final String message;
}


