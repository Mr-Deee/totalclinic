import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';


class UserRepo {
  CollectionReference reference = FirebaseFirestore.instance.collection("user");

  Stream<QuerySnapshot> getStream() {
    return reference.snapshots();
  }

  Stream getReferenceSnapshots(String uid) {
    return reference.doc(uid).snapshots();
  }

  Future<void> addUser(User user) {
    //  return reference.add(user.toJson());
    return reference.doc(user.uid).set(user.toJson());
  }

  checkIfUserExists(String uid) async {
    var snapshot = await reference.doc(uid).get();
    if (snapshot == null || !snapshot.exists) {
      return false;
    }
    return true;
  }

  Future<DocumentSnapshot> getConfirmedUser(String uid) async {
    return reference.doc(uid).get();
  }

  updateUser(User newUser) async {
    print("-----------------------------------URL{" +
        newUser.imageUrl.toString() +
        "}-------------------\n uid:{$newUser.uid}");
    await FirebaseFirestore.instance
        .collection('user')
        .doc(newUser.uid)
        .update(newUser.toJson());
  }
}
