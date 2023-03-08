import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


import 'package:encrypt/encrypt.dart' as EncryptPack;

import 'package:dio/dio.dart' as dios;
import 'package:get_storage/get_storage.dart';


import '../../Pages/home.dart';
import '../../models/DoctorUserProfile.dart';
import '../../models/user_model.dart';
import '../../progressDialog.dart';
import '../Views/profile_status.dart';
import '../auth_services.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  DoctorUserModel? Duser;
  bool isLoading = false;
  final _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference Doctors=
      FirebaseFirestore.instance.collection('Doctors');
  CollectionReference clients =
      FirebaseFirestore.instance.collection('Users');

  @override
  void onInit() {
    initt();
    super.onInit();
  }

  initt() async {
    if (auth.currentUser?.uid != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        Duser = await getUser(
            getUserFromStorage()!.email, getUserFromStorage()!.password);
        // user!.status == "enable"
        //     ? Get.offAllNamed(DashboardScreen.routeName)
        //     : Get.offAllNamed(ProfileStatus.routeName);
      });
    } else {
      UserModel? a = getStudentFromStorage();
      if (a != null) {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          Get.offAllNamed(HomeScreen.idScreen, arguments: a);
        });
      }
    }
  }

  Future<DoctorUserModel?> getUser(email, password) async {
    QuerySnapshot user = await Doctors
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password.toString())
        .get();
    log('User Doc ${user.docs}');
    if (user.docs.isEmpty) {
      showSnackBar("User Data Not Found");
      logOut();
      return null;
    }

    DoctorUserModel userModel =
    DoctorUserModel.fromMap(user.docs.first.data() as Map<String, dynamic>);
    setUser(userModel);
    setKey(auth.currentUser!.uid);
    if (userModel.status == "enable") {
      // Get.offAllNamed(DashboardScreen.routeName);
    } else {
      Get.offAllNamed(ProfileStatus.routeName);
    }
    return userModel;
  }

  Future<UserModel?> getClient(email, rollNo) async {
    QuerySnapshot user = await clients
        .where("email", isEqualTo: email)

        .get();
    log('Student Doc ${user.docs}');
    if (user.docs.isEmpty) {
      showSnackBar("Enter Valid Email");
      logOut();
      return null;
    }

    UserModel userModel =
    UserModel.fromMap(user.docs.first.data() as Map<String, dynamic>);

    return userModel;
  }

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  login(email, password,BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Logging you in,Please wait.",
          );
        });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //String token = userCredential.credential!.token.toString();

      getUser(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        showSnackBar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        showSnackBar("Wrong password provided for that user.");
      }
    }
  }

  registerUser(fname,lname, email, phone, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      DoctorUserModel userModel = DoctorUserModel(
          uid: userCredential.user!.uid,
          FirstName: fname,
          LastName: lname,
          email: email,
          password: password,
          status: "enable",
          timeStamp: DateTime.now().microsecondsSinceEpoch);
      Doctors
          .doc(userCredential.user!.uid)
          .set(userModel.toJson())
          .then((value) {
        setKey(userModel.uid!);
        setUser(userModel);
        Get.offAllNamed(ProfileStatus.routeName);
      });


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        showSnackBar("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        showSnackBar("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  String? getKey() {
    if (GetStorage().read("api_key") != null) {
      return GetStorage().read("api_key");
    } else {
      return null;
    }
  }

  DoctorUserModel? getUserFromStorage() {
    if (GetStorage().read("user") != null) {
      return DoctorUserModel.fromMap(GetStorage().read("user"));
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    GetStorage().remove("api_key");
    GetStorage().remove("user");
    GetStorage().erase();
  }

  setUser(DoctorUserModel userModel) {
    GetStorage().write('user', userModel.toJson());
  }

  setStudent(UserModel studentModel) {
    GetStorage().write('student', studentModel.toJson());
  }

  UserModel? getStudentFromStorage() {
    if (GetStorage().read("student") != null) {
      return UserModel.fromMap(GetStorage().read("student"));
    }
  }

  setKey(String key) {
    GetStorage().write("api_key", key);
  }
}

showSnackBar(text) {
  final snackBar = SnackBar(content: Text(text));
  if (Get.context != null) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
