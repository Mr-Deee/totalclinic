import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';



User firebaseUser;
Future<void> getUsername(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.reference();
  User user = await auth.currentUser;
  ref.child("Clients").child(user.uid);
  // firebaseUser = await FirebaseAuth.instance.currentUser!;
  String userId = firebaseUser.uid;
  DatabaseReference userRef = FirebaseDatabase.instance.reference().child(
      "Clients").child(userId);

  final snapshot = await userRef.get(); // you
  if (snapshot.value != null) {
    userCurrentInfo = UserProfile.fromSnapshot(snapshot);
  }


}


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



  UserProfile({
   this. ,

});







UserProfile.fromSnapshot(DataSnapshot dataSnapShot) {
id = dataSnapShot.key!;
var data = dataSnapShot.value as Map;
name = data["name"];
// client_name = dataSnapShot.value["client_name"];
// client_phone = dataSnapShot.value["client_phone"];
// created_at = dataSnapShot.value[" created_a"];
// driver_id = dataSnapShot.value!["driver_id"];
// driver_name=dataSnapShot.value["driver_name"];
// driver_phone=dataSnapShot.value["driver_phone"];
// dropoff_address=dataSnapShot.value["dropoff_address"];
// pickup_address=dataSnapShot.value["pickup_address"];
// ride_type=dataSnapShot.value["ride_type"];
}
