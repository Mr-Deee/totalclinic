import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

UserProfile userCurrentInfo;

User firebaseUser;
final CollectionReference _userRef =
FirebaseFirestore.instance.collection('users');

class UserProfile {
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





}

