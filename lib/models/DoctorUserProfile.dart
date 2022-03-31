import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:totalclinic/models/user_model.dart';

class DoctorUserModel extends ChangeNotifier {
  String uid;
  String FirstName;
  String LastName;
  String email;
  String profileImage;
  int dob;
  String Gender;

  DoctorUserModel({
    this.uid,
    this.FirstName,
    this.LastName,
    this.email,
    this.profileImage,
    this.dob,
    this.Gender,
  });

  static DoctorUserModel fromMap(Map<String, dynamic> map) {
    return DoctorUserModel(
      uid: map['uid'],
      FirstName: map['firstName'],
      LastName: map["lastName"],
      Gender: map["Gender"],
      email: map['email'],
      profileImage: map['profileImage'],
      dob: map['d0b'],
    );
  }
  DoctorUserModel _userInfo;

  DoctorUserModel get userInfo => _userInfo;

  void setUser(DoctorUserModel userModel) {
    _userInfo = userModel;

  }

  static void getCurrentOnlineUserInfo(BuildContext context) async {
    print('assistant methods step 3:: get current online user info');
    firebaseUser =
        FirebaseAuth.instance.currentUser; // CALL FIREBASE AUTH INSTANCE
    print('assistant methods step 4:: call firebase auth instance');
    String userId =
        firebaseUser.uid; // ASSIGN UID FROM FIREBASE TO LOCAL STRING
    print('assistant methods step 5:: assign firebase uid to string');
    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child("Doctors").child(userId);
    print(
        'assistant methods step 6:: call users document from firebase database using userId');
    reference.once().then(( event) async {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value!= null) {
//userCurrentInfo = Users.fromSnapshot(dataSnapshot);
// IF DATA CALLED FROM THE FIREBASE DOCUMENT ISN'T NULL
// =userCurrentInfo = Users.fromSnapshot(
//     dataSnapShot);ASSIGN DATA FROM SNAPSHOT TO 'USERS' OBJECT

        DatabaseEvent event = await reference.once();

        context.read<UserModel>().setUser(UserModel.fromMap(Map<String, dynamic>.from(event.snapshot.value as dynamic)));
        print(
            'assistant methods step 7:: assign users data to usersCurrentInfo object');
      }
    });
  }

}
