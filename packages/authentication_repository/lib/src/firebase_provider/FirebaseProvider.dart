import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/extensions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

enum AppLifecycleStatus{
  online,
  offline
}
class FirebaseProvider {


  static final FirebaseProvider _inst = FirebaseProvider._internal();
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  FirebaseProvider._internal();

  factory FirebaseProvider(MainUserData currentUser) {
    _inst.currentUser = currentUser;
    return _inst;
  }

  MainUserData? currentUser;
  final DatabaseReference _mainReference =
  FirebaseDatabase.instance.ref();
  late final DatabaseReference _databaseReferenceUsers = _mainReference.child("Users");

  late DatabaseReference notificationReference = _mainReference.child("Notifications");

  Stream<List<FirebaseUserNotification>> getNotificationsData() =>
      notificationReference.child(currentUser?.user?.email.encodeEmail() ?? "").onValue.map((event){
          return event.snapshot.children
              .map((e) =>FirebaseUserNotification.fromJson(Map<String, dynamic>.from(e.value as dynamic)))
              .toList();
      });

  void updateUserOnline(AppLifecycleStatus status)async{
    final user = this.currentUser?.user;
    if(user != null && user.email.isNotEmpty){
      await _databaseReferenceUsers.child(user.email.encodeEmail()).update({
        "online": status == AppLifecycleStatus.online ? true : ServerValue.timestamp,
      });
    }
  }

  updateUserWithData(String token)async{

    final user = this.currentUser?.user;
    final employeeData = this.currentUser?.employeeData;


    await _databaseReferenceUsers.child(user!.email.encodeEmail()).update({
      // "device_token": token,
      "hrcode": user.userHRCode,
      "imgProfile": employeeData?.imgProfile,
      "managerCode":employeeData?.managerCode,
      // "managerEmail":,
      "title":employeeData?.titleName,
      "userID":_firebaseAuth.currentUser?.uid,
      "username":employeeData?.name,

    });
  }

  // StreamSubscription<List<Notification>> getNotificationsData(String email)  {
  //   // return notificationReference.child(email).onValue.listen((event) { })
  //   return notificationReference.child(email).onValue.listen((DatabaseEvent event) {
  //     // final data = Map<String, dynamic>.from(event.snapshot.value);
  //     final data = event.snapshot.value!;
  //     final  notifications = Notification.fromJson(data as Map<String, dynamic>);
  //     // final currencyList = Currency.fromJson(data);
  //     return notifications;
  //     // return(data);
  //   });
  // }

}
