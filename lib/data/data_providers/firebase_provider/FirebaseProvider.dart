import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hassanallamportalflutter/data/models/firebase_models/notification_model/Notification.dart';

class FirebaseProvider {

  FirebaseProvider({required this.currentUser});
  User currentUser;
  DatabaseReference mainReference =
  FirebaseDatabase.instance.ref();

  late DatabaseReference notificationReference = mainReference.child("Notifications");

  Stream<List<FirebaseUserNotification>> getNotificationsData() =>
      notificationReference.child(currentUser.email.replaceAll(".", ",")).onValue.map((event){
          return event.snapshot.children
              .map((e) =>FirebaseUserNotification.fromJson(Map<String, dynamic>.from(e.value as dynamic)))
              .toList();
      });

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