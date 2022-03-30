import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getAllDoctors() async {
    return FirebaseFirestore.instance
        .collection("Doctors")
        .orderBy("rank")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getAllDoctorsPagination(documentLimit) async {
    return await FirebaseFirestore.instance
        .collection("Doctors")
        .orderBy("rank")
        .limit(documentLimit)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getAllDoctorsPaginationStartAfter(documentLimit, lastDocument) async {
    return await FirebaseFirestore.instance
        .collection("Doctors")
        .orderBy("rank")
        .startAfterDocument(lastDocument)
        .limit(documentLimit)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorBySearch(String searchString) async {
    return await FirebaseFirestore.instance
        .collection("Doctors")
        .where("LastName", isGreaterThanOrEqualTo: searchString)
        .where("LastName", isLessThanOrEqualTo: searchString + "z")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorBySpecialty(String specialty) async {
    return await FirebaseFirestore.instance
        .collection("Doctors")
        .where("specialty", isEqualTo: specialty)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getAllSpecialties() async {
    return FirebaseFirestore.instance
        .collection("Specialties")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getSpecialty(String specialty) async {
    return FirebaseFirestore.instance
        .collection("Specialties")
        .where("specialty", isEqualTo: specialty)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorProfile(String lastName) async {
    return FirebaseFirestore.instance
        .collection("Doctors")
        .where("LastName", isEqualTo: lastName)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorOfficeGallery(String lastName) async {
    return FirebaseFirestore.instance
        .collection("officeGalleries")
        .where("LastName", isEqualTo: lastName)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserProfile(String email) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
}
