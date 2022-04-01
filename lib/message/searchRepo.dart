import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/sharedPrefs.dart';

import 'package:rxdart/rxdart.dart';

import '../user/user.dart';

class SearchRepo {
  CollectionReference reference = FirebaseFirestore.instance.collection("user");

  PublishSubject<List<User>> searchResult = PublishSubject();
  PublishSubject loading = PublishSubject();

  Future<bool> checkIfUserExists(String uid) async {
    loading.add(true);
    var snapshot = await reference.doc(uid).get();
    loading.add(false);
    if (snapshot == null || !snapshot.exists) {
      searchResult.add([]);
      return false;
    }
    return true;
  }

  Future<bool> checkUserExistsByUserName(String userName) async {
    loading.add(true);
    var documents = await reference.get();
    var a = documents.docs.where((element) {
      //return element.data['userName'] == userName;
    });

    loading.add(false);

    List value = a.map((e) => User.fromSnapshot(e)).skipWhile((value) {
      return value.uid == sharedPrefs.getValueFromSharedPrefs('uid');
    }).toList();

    if (value.length <= 0) {
      searchResult.add([]);
      return false;
    }
    searchResult.add(value);
    return true;
  }

  Future getConfirmedUser(String uid) async {
    print(" in confirmed user + " + uid);
    loading.add(true);

    // DocumentSnapshot a =
    //     await reference.doc(uid).get(source: Source.serverAndCache);

    loading.add(false);
    // User searchUser = User.fromSnapshot();
    // if (searchUser.uid != sharedPrefs.getValueFromSharedPrefs("uid")) {
    //   searchResult.add([searchUser]);
    //   return 1;
    // } else {
    //   searchResult.add([]);
    //   return 0;
    // }
  }
}

SearchRepo searchRepo = SearchRepo();
