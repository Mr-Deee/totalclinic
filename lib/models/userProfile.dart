import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

UserProfile userCurrentInfo;


Future getUsername() async {
  final ref = FirebaseDatabase.instance.reference();
  User cuser = await FirebaseAuth.instance.currentUser;
  final snapshot = await ref.get(); // you
  ref.child('Clients').child(cuser.uid);
  if (snapshot.value != null) {
    userCurrentInfo = UserProfile.fromSnapshot(snapshot);
    // ref.child('User_data').child(cuser.uid).once().then((DataSnapshot snap) {
    //   final  String userName = snap.value['name'].toString();
    //   print(userName);
    //   return userName;
    // });
  }


}
class UserProfile {
  static String id="";
   static String userImagePath = "";
   static String userFirstName = "";
   static String userLastName = "";
  static String userEmail = "";
  static double userHealthScore = 0;
  static String userWeight = "";
  static String userHeight = "";
  static String userAge = "";
  static String userAddress = "";
  static String userBMI = "";
  static String userLanguage = "";
  static String userPhone = "";
  static String userGender = "";
  static String userDOB = "";



  UserProfile.fromSnapshot(DataSnapshot dataSnapShot) {
    Map<String, dynamic> data = dataSnapShot.value as Map<String, dynamic>;
    id = dataSnapShot.key;

    userFirstName = data["name"];
    userEmail = data["email"];
    // client_phone = dataSnapShot.value["client_phone"];
    // created_at = dataSnapShot.value[" created_a"];
    // driver_id = dataSnapShot.value!["driver_id"];
    // driver_name=dataSnapShot.value["driver_name"];
    // driver_phone=dataSnapShot.value["driver_phone"];
    // dropoff_address=dataSnapShot.value["dropoff_address"];
    // pickup_address=dataSnapShot.value["pickup_address"];
    // ride_type=dataSnapShot.value["ride_type"];
  }



}

