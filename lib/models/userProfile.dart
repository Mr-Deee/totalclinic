import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

UserProfile? userCurrentInfo;


Future getUsername() async {
  final ref = FirebaseDatabase.instance.reference();
  User? cuser = FirebaseAuth.instance.currentUser;
  final snapshot = await ref.get(); // you
  ref.child('Users').child(cuser!.uid);
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
    id = dataSnapShot.key!;

    userFirstName = data["FirstName"];
    userEmail =     data["Email"];
    userLastName  = data["LastName"];




  }



}

