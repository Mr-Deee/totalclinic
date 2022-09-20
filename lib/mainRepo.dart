import 'package:cloud_firestore/cloud_firestore.dart';

import './data/sharedPrefs.dart';
import 'user/user.dart';

class MainRepo {
  var reference = FirebaseFirestore.instance.collection("message");
  DocumentReference ?documentReference;
//* TODO: Get all users the current user is messaging with

  Stream<QuerySnapshot> getStream() {
    var uid = sharedPrefs.getValueFromSharedPrefs('uid');

    return reference
        .where(
          "participants",
          arrayContains: uid,
        )
        .orderBy('date', descending: true)
        .snapshots();
  }

  Stream getUserStream(String uid) {
    return FirebaseFirestore.instance.collection('user').doc(uid).snapshots();
  }

  Future<User?> getUserFromUid(String uid) async {
    print('getting user from uid : $uid');
    QuerySnapshot a = await FirebaseFirestore.instance
        .collection('user')
        .where('uid', isEqualTo: uid)
        .get();
    //User user = User.fromJson(a.docs[0]);

    //return user;
  }
}

MainRepo mainRepo = MainRepo();
