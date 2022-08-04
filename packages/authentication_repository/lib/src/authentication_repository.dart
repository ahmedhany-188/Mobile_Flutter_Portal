import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/src/authentication_provider.dart';
// import 'package:firebase_auth/f
import 'package:firebase_auth/firebase_auth.dart'as flutter_firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

enum AuthenticationStatus {authenticated, unauthenticated}
class AuthenticationRepository {
  late final AuthenticationProvider authenticationProvider = AuthenticationProvider();
  final StreamController<MainUserData>_controller = StreamController<MainUserData>.broadcast();
  static const userCacheKey = '__user_cache_key__';
  static const employeeCacheKey = '__employeeData__';
  // final CacheClient _cache = CacheClient();
  late SharedPreferences shared_User;
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // DatabaseReference _databaseReferenceUsers = FirebaseDatabase.instance.ref("Users");

  static final AuthenticationRepository? _singleton = AuthenticationRepository();
  static getInstance(){
    if(_singleton != null){
      return _singleton;
    }else{
      return AuthenticationRepository();
    }
  }
  AuthenticationRepository(){
    init();
  }
  Future  init() async {
    print("init shared user");
    shared_User = await SharedPreferences.getInstance();

    try{
      await _firebaseAuth.currentUser?.reload();
    }on firebase_auth.FirebaseAuthException catch (e){
      if (e.code == 'user-disabled') {
        // User is disabled.
        // _controller.add(MainUserData.empty);
        await Future.wait([
          shared_User.remove(userCacheKey),
          shared_User.remove(employeeCacheKey),
          shared_User.clear(),
          // _firebaseAuth.signOut(),
        ]);

      }
    }
  }

  Stream<MainUserData> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    try{
      if (_firebaseAuth.currentUser != null){
        String? data = await shared_User.getString(userCacheKey);
        Map userMap = jsonDecode(data!);
        var user = User.fromJson(userMap as Map<String, dynamic>);
        String? dataEmployee = await shared_User.getString(employeeCacheKey);
        Map employeeMap = jsonDecode(dataEmployee!);
        var employeeData = EmployeeData.fromJson(employeeMap as Map<String, dynamic>);
        var mainUserData = MainUserData(user: user,employeeData: employeeData);
        // yield mainUserData;
        _controller.add(mainUserData);
      }else{
        _controller.add(MainUserData.empty);
        // yield MainUserData.empty;
      }

    }catch(e){
      _controller.add(MainUserData.empty);
      // yield MainUserData.empty;
    }


    // yield _cache.read<User>(key: userCacheKey) ?? User.empty;;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    //  authentication provider to api functions
    await authenticationProvider.loginApiAuthentication(username, password)
        .then(
            (value) async {
          if (value.statusCode == 200) {
            final loginTokenDataJson = await jsonDecode(value.body);
            try {
              User user = User.fromJson(loginTokenDataJson[0]);
              String userData = jsonEncode(loginTokenDataJson[0]);
              //TODO : Add Signup firebase if not sign in before
              await logInWithEmailAndPassword(email: user.email,password: "12345678");
              shared_User.setString(userCacheKey, userData);

              // if (Platform.isIOS){
              //   _firebaseMessaging.requestPermission(
              //       sound: true, badge: true, alert: true
              //   );
              //   _firebaseMessaging.onIosSettingsRegistered
              //       .listen((IosNotificationSettings settings)
              //   {
              //     print("Settings registered: $settings");
              //   });
              //   // _firebaseMessaging.requestPermission()
              // }
              await authenticationProvider.getEmployeeData(user.userHRCode!).then((value) async {
                print(value);
                if (value.statusCode == 200) {
                  final employeeDataJson = await jsonDecode(value.body);
                  EmployeeData employeeData = EmployeeData.fromJson(employeeDataJson[0]);


                  var managerResponse = await authenticationProvider.getEmployeeData(employeeData.managerCode!);
                  final managerDataJson = await jsonDecode(managerResponse.body);
                  EmployeeData managerEmployeeData = EmployeeData.fromJson(managerDataJson[0]);

                  //TODO : Add manager data in employee data

                  String employeeDataString = jsonEncode(employeeData.toJson());
                  shared_User.setString(employeeCacheKey, employeeDataString);
                  print(employeeData.toString());

                  //TODO : Add FirebaseMessaging for IOS
                  await _firebaseMessaging.getToken().then((token) async {
                    print("FCM --> $token");
                    await FirebaseProvider(MainUserData(employeeData: employeeData,user: user)).updateUserWithData(token!);
                  });
                  _controller.add(MainUserData(employeeData: employeeData,user: user));
                }
              });
            } on flutter_firebase_auth.FirebaseAuthException catch (e) {
              // print(e);
              throw LogInWithEmailAndPasswordFailureFirebase.fromCode(e.code);
            } catch (message) {
              throw message;
            }
          } else {
            throw LogInWithEmailAndPasswordFailureApi.fromCode(
                value.statusCode);
          }
        });
  }
  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on flutter_firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailureFirebase.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailureFirebase();
    }
  }
  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on flutter_firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailureFirebase.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailureFirebase();
    }
  }

  Future<void> logOut() async {
    try {
      _controller.add(MainUserData.empty);
      // add all functions to log out from user
      await Future.wait([
        shared_User.remove(userCacheKey),
        shared_User.remove(employeeCacheKey),
        shared_User.clear(),
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      // throw LogOutFailure();
    }
  }
  Stream<MainUserData> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? MainUserData.empty : currentUser;
      return user;
    });
  }

  MainUserData get currentUser {
    try{
      // try{
      // await firebase_auth.FirebaseAuth.instance.currentUser?.reload();
      // if(_firebaseAuth.currentUser != null){
        print(_firebaseAuth.currentUser);
        // String? data = shared_User.getString(userCacheKey);
        // Map userMap = jsonDecode(data!);
        // var user = getFromJson(userMap as Map<String, dynamic>);
        // return user;

        String? data = shared_User.getString(userCacheKey);
        Map userMap = jsonDecode(data!);
        var user = User.fromJson(userMap as Map<String, dynamic>);
        String? dataEmployee = shared_User.getString(employeeCacheKey);
        Map employeeMap = jsonDecode(dataEmployee!);
        var employeeData = EmployeeData.fromJson(employeeMap as Map<String, dynamic>);
        var mainUserData = MainUserData(user: user,employeeData: employeeData);
        return mainUserData;
      // }else{
      //   return User.empty;
      // }

    }catch(e){
      return MainUserData.empty;
    }
  }

  // Stream<User> get user async* {
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   var user = _cache.read<User>(key: userCacheKey) ?? User.empty;
  //   yield user;
  // }

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
        print("Email is not valid or badly formatted.");
        return const LogInWithEmailAndPasswordFailureFirebase(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        print("This user has been disabled. Please contact support for help.");
        return const LogInWithEmailAndPasswordFailureFirebase(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        print("Email is not found, please create an account.");
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


