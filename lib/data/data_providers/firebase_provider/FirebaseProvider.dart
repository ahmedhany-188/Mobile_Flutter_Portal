import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hassanallamportalflutter/data/models/firebase_models/notification_model/Notification.dart';
import 'package:hassanallamportalflutter/life_cycle_states.dart';

class FirebaseProvider {


  static final FirebaseProvider _inst = FirebaseProvider._internal();

  FirebaseProvider._internal();

  factory FirebaseProvider(User currentUser) {
    _inst.currentUser = currentUser;
    return _inst;
  }
  // static final FirebaseProvider? _singleton = null;
  // static getInstance(User currentUser){
  //   if(_singleton != null){
  //     return _singleton;
  //   }else{
  //     return FirebaseProvider(currentUser: currentUser);
  //   }
  // }
  // FirebaseProvider({required this.currentUser});
  User? currentUser;
  final DatabaseReference _mainReference =
  FirebaseDatabase.instance.ref();
  late final DatabaseReference _databaseReferenceUsers = _mainReference.child("Users");

  late DatabaseReference notificationReference = _mainReference.child("Notifications");

  Stream<List<FirebaseUserNotification>> getNotificationsData() =>
      notificationReference.child(currentUser?.email.replaceAll(".", ",") ?? "").onValue.map((event){
          return event.snapshot.children
              .map((e) =>FirebaseUserNotification.fromJson(Map<String, dynamic>.from(e.value as dynamic)))
              .toList();
      });

  void updateUserOnline(AppLifecycleStatus status)async{
    await _databaseReferenceUsers.child(currentUser?.email.replaceAll(".", ",")??"").update({
      "online": status == AppLifecycleStatus.online ? true : ServerValue.timestamp,
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