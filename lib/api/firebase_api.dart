import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:totalclinic/models/userProfile.dart';

import '../data.dart';
import '../models/message.dart';
import '../models/userfeild.dart';
import '../utils.dart';




class FirebaseApi {

  static StreamSubscription<DatabaseEvent>getDoctorUsers() => FirebaseDatabase.instance.reference().child("Doctors").onValue.listen((event) {
    final data = Map<String, dynamic>.from(event.snapshot.value);
    final DoctorUserS = DoctorUser.fromMap(data);
    return DoctorUserS;
  });
  // static Stream<List<DoctorUser>> getDoctorUsers() => FirebaseFirestore.instance
  //     .collection('Users')
  //     .orderBy(UserField.lastMessageTime, descending: true)
  //     .snapshots()
  //     .transform(Utils.transformer(DoctorUser.fromJson));

  // static Stream<List<User>> getUsers() => FirebaseFirestore.instance
  //     .collection('Users')
  //     .orderBy(UserField.lastMessageTime, descending: true)
  //     .snapshots()
  //     .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser:  myId,
      urlAvatar: myUrlAvatar,
      username:  myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('Users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<DoctorUser> users) async {
    final refUsers = FirebaseFirestore.instance.collection('Users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
