import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:totalclinic/models/user_model.dart';

import '../utils.dart';



class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String idUser;
  final String name;
  final String urlAvatar;
  final DateTime lastMessageTime;

  const User({
    this.idUser,
    @required this.name,
    @required this.urlAvatar,
    @required this.lastMessageTime,
  });

  User copyWith({
    String idUser,
    String name,
    String urlAvatar,
    String lastMessageTime,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
       // urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        name: json['FirstName'],
        //urlAvatar: json['urlAvatar'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'FirstName': name,
        //'urlAvatar': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}


class DoctorUser extends ChangeNotifier{
  final String idUser;
  final String name;
  final String urlAvatar;
  final DateTime lastMessageTime;

   DoctorUser({
  this.idUser,
  @required this.name,
  @required this.urlAvatar,
  @required this.lastMessageTime,});

  DoctorUser copyWith({
    String idUser,
    String name,
    String urlAvatar,
    String lastMessageTime,
  }) =>
      DoctorUser(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        // urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );


  static DoctorUser fromMap(Map<String, dynamic> map) => DoctorUser(
    //idUser: map['idUser'],
    name: map['name'],
    //urlAvatar: json['urlAvatar'],
    lastMessageTime: Utils.toDateTime(map['lastMessageTime']),
  );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'FirstName': name,
    //'urlAvatar': urlAvatar,
    'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
  };
  DoctorUser _userInfo;

  DoctorUser get userInfo => _userInfo;

  void setUser(DoctorUser user) {
    _userInfo = user;
    notifyListeners();
  }
  getCurrentOnlineDoctorInfo(BuildContext context) async {
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

        context.read<DoctorUser>().setUser(DoctorUser.fromMap(Map<String, dynamic>.from(event.snapshot.value as dynamic)));
        print(
            'assistant methods step 7:: assign users data to usersCurrentInfo object');
      }
    });
  }
  }












