import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class StorageService {
  PublishSubject imageUrl = PublishSubject();
  PublishSubject chatImageUrl = PublishSubject();

  PublishSubject editProfileIsLoading = PublishSubject();

  Future<PickedFile?> pickFile() async {
    try {
      PickedFile? file =
          await ImagePicker().getImage(source: ImageSource.gallery);
      return file;
    } catch (e) {
      Fluttertoast.showToast(msg: "Select an image");
      return null;
    }
  }

  Future uploadChatImage(
      PickedFile file, String documentID, DateTime time) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('chats/$documentID/${time.millisecondsSinceEpoch.toString()}');
      File properFile = File(file.path);

      UploadTask uploadTask = storageReference.putFile(properFile);
      await uploadTask;
      print('File Uploaded');
      var url = await storageReference.getDownloadURL();

      chatImageUrl.add(url);
      return url;
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occured while uploading the image");
      return null;
    }
  }

  uploadFile(PickedFile file) async {
    editProfileIsLoading.add(true);
    User? user = FirebaseAuth.instance.currentUser;
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profiles/${user?.uid}');
    File properFile = File(file.path);

    UploadTask uploadTask = storageReference.putFile(properFile);
    await uploadTask;
    print('File Uploaded');
    var url = await storageReference.getDownloadURL();
    imageUrl.add(url);
    editProfileIsLoading.add(false);
  }
}

StorageService storageService = StorageService();
