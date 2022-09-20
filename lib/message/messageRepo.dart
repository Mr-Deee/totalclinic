import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'message.dart';
import '../groupModel.dart';

class MessageRepo {
  CollectionReference reference = FirebaseFirestore.instance.collection("message");

//? Check if room exists else create it
  setReference(GroupModel model) async {
    print(" in set reference ");
    QuerySnapshot a = await FirebaseFirestore.instance
        .collection("message")
        .where('participants', isEqualTo: model.participants)
        .get();

    print("First query results = : ${a.docs.length}");

    if (a.docs.length <= 0) {
      print(" in if ----checking another way");
      a = await FirebaseFirestore.instance.collection("message").where('participants',
          isEqualTo: [
            model.participants![1],
            model.participants![0]
          ]).get();
    }

    if (a.docs.length > 0) {
      print(" in set reference  -- if -- \n ");
      var e = a.docs[0].reference;

      reference = e.collection("messages");
    } else {
      print(" in set reference --else -- \n");
      await FirebaseFirestore.instance.collection('message').doc().set(
          {'participants': model.participants, 'date': DateTime.now()},
          //merge: true
      );

      QuerySnapshot a = await FirebaseFirestore.instance
          .collection('message')
          .where('participants', isEqualTo: model.participants)
          .get();

      var e = a.docs[0].reference;
      reference = e.collection("messages");
    }
  }

  Stream<QuerySnapshot> getStream() {
    return reference.orderBy("date", descending: true).snapshots();
  }

  Future<void> addMessage(Message message, GroupModel model, var docId) {
    updateTime(docId, message.date!, model);
    return reference
        .doc(message.date!.millisecondsSinceEpoch.toString())
        .set(message.toJson());
  }

  updateTime(String docId, DateTime date, GroupModel model) {
    FirebaseFirestore.instance
        .collection('message')
        .doc(docId)
        .set({'participants': model.participants, 'date': date});
  }

  Future getGroupDocumentId(GroupModel model) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("message")
        .where(
          'participants',
          isEqualTo: model.participants,
        )
        .get();
    if (snapshot.docs.length <= 0) return null;
    return snapshot.docs[0].id;
  }

  Stream getLastMessage(GroupModel model, var documentId) {
    return FirebaseFirestore.instance
        .collection('message')
        .doc(documentId)
        .collection('messages')
        .snapshots();
  }

  deleteMessage(Message message) async {
    if (message.message != "This message has been deleted") {
      await reference
          .doc(message.date!.millisecondsSinceEpoch.toString())
          .update(
            Message(
                    message: "This message has been deleted",
                    date: message.date,
                    idFrom: message.idFrom,
                    idTo: message.idTo,
                    documentId: message.documentId,
                    isSeen: message.isSeen,
                    type: 0)
                .toJson(),
          );
    }
  }

  clearChat(GroupModel model) async {
    print('-------------in Clear chat--------- ');
    getGroupDocumentId(model).then((value) async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('message')
          .doc(value)
          .collection('messages')
          .get();

        var inst = FirebaseFirestore.instance.collection('message').doc(value);

      if (querySnapshot.docs.length > 0) {
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          Message message = Message.fromSnapshot(querySnapshot.docs[i]);
          if (message.type == 1) {
            deleteImageCompletely(value, message);
            inst
                .collection('messages')
                .doc(message.date!.millisecondsSinceEpoch.toString())
                .delete();
          } else {
            print("\n--- Deleting message(${message.documentId})---\n ");
            inst
                .collection('messages')
                .doc(message.date!.millisecondsSinceEpoch.toString())
                .delete();
          }
        }
      }
    });
  }

  deleteGroup(GroupModel model) async {
    _printer(" in delete group ");
    getGroupDocumentId(model).then((value) async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('message')
          .doc(value)
          .collection('messages')
          .where('type', isEqualTo: 1)
          .get();

      if (querySnapshot.docs.length > 0) {
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          Message message = Message.fromSnapshot(querySnapshot.docs[i]);
          deleteImageCompletely(value, message);
        }
      }
      FirebaseFirestore.instance.collection("message").doc(value).delete();
    });
  }

  deleteImageCompletely(String documentId, Message message) {
    FirebaseStorage.instance
        .ref()
        .child('chats/$documentId/${message.date!.millisecondsSinceEpoch}')
        .delete()
        .then((value) {
      _printer("-Deleted message completely-");
    });
  }

  deleteImage(String documentId, Message message) {
    deleteMessage(message);
    FirebaseStorage.instance
        .ref()
        .child('chats/$documentId/${message.date!.millisecondsSinceEpoch}')
        .delete()
        .then((value) {
      _printer("-Deleted message completely-");
    });
  }

  updateIsSeen(Message message) async {
    await reference
        .doc(message.date!.millisecondsSinceEpoch.toString())
        .update(
          Message(
                  message: message.message,
                  date: message.date,
                  idFrom: message.idFrom,
                  idTo: message.idTo,
                  documentId: message.documentId,
                  isSeen: true,
                  notificationShown: message.notificationShown,
                  imageUrl: message.imageUrl,
                  type: message.type)
              .toJson(),
        );
  }

  updateIsNotificationShown(Message message) async {
    await FirebaseFirestore.instance
        .collection('message')
        .doc(message.documentId)
        .collection("messages")
        .doc(message.date!.millisecondsSinceEpoch.toString())
        .update(Message(
                message: message.message,
                date: message.date,
                idFrom: message.idFrom,
                idTo: message.idTo,
                documentId: message.documentId,
                isSeen: message.isSeen,
                notificationShown: true,
                imageUrl: message.imageUrl,
                type: message.type)
            .toJson());
  }

  getChatRoom(String uid) async {
    _printer("getChatRoom [MessageRepo.dart]");
    /*  Stream<QuerySnapshot> a = Firestore.instance
        .collection("message")
        .where('participants', arrayContains: uid)
        .getDocuments()
        .asStream();
    _printer("-");

    return a; */
    var a = await FirebaseFirestore.instance
        .collection('message')
        .where(
          'participants',
          arrayContains: uid,
        )
        .get();
    var b = a.docs[0].reference;
    b.collection("message").add({'kuchbhi': "aur nitpo lue"});
  }
}

_printer(String text) {
  print(
      "\n\n--------------------------------$text---------------------------\n\n");
  print("\n\n\n");
}

MessageRepo messageRepo = MessageRepo();
