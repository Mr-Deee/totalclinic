import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:totalclinic/DoctorDatabase.dart';
import 'package:totalclinic/Pages/DoctorProfile.dart';
import 'package:totalclinic/Pages/SignUpPage.dart';
import 'package:totalclinic/Pages/askquestion.dart';
import 'package:totalclinic/components/drawer/custom_drawer.dart';

import 'package:totalclinic/services/shared_preferences.dart';
import 'package:totalclinic/widgets.dart';
import 'package:totalclinic/widgets/AdminSelection.dart';

import '../models/userProfile.dart';
import '../models/user_model.dart';
import 'Dentist.dart';
import 'Gynecologist.dart';
import 'Pharmacist.dart';

DocumentSnapshot? snapshot;

class HomeScreen extends StatefulWidget {
  static const String idScreen = "HomePage";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

DatabaseReference? _ref;

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  UserModel? userModel;
  DatabaseReference? Clients;
  Future<void>? _launched;
  String _phone = '123-456-7890';
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot? doctorSnapshot;
  QuerySnapshot? specialtySnapshot;
  QuerySnapshot? doctorSpecialtyCount;
  QuerySnapshot? userProfileSnapshot;
  List<DocumentSnapshot> loadedDoctors = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 1;
  DocumentSnapshot? lastDocument;

  getDoctors() async {
    databaseMethods.getAllDoctors().then((val) {
      print(val.toString());
      setState(() {
        doctorSnapshot = val;
        print(doctorSnapshot);
      });
    });
  }

  paginateDoctors() async {
    if (!hasMore) {
      print('No More Products');
      return;
    }
    if (isLoading) {
      return;
    }
    if (lastDocument == null) {
      databaseMethods.getAllDoctorsPagination(documentLimit).then((val) {
        setState(() {
          doctorSnapshot = val;
          print(
              "pulling doctors without having loaded any more, Document Limit is:");
          print(documentLimit);
          setState(() {
            isLoading = false;
          });
        });
      });
    } else {
      databaseMethods
          .getAllDoctorsPaginationStartAfter(documentLimit, lastDocument)
          .then((val) {
        setState(() {
          doctorSnapshot = val;
          print("pulling NEW doctors, lastDocuments is:");
          print(lastDocument);
          setState(() {
            isLoading = false;
          });
        });
      });
    }
    // if (doctorSnapshot.docs.length < documentLimit) {
    //   hasMore = false;
    //   print("hasMore = false");
    // }
    // lastDocument = doctorSnapshot.docs[doctorSnapshot.docs.length - 1];
    // loadedDoctors.addAll(doctorSnapshot.docs);
    // setState(() {
    //   isLoading = false;
    // });
  }

  void setLoading([bool value = false]) => setState(() {
        isLoading = value;
      });

  getSpecialties() async {
    databaseMethods.getAllSpecialties().then((val) {
      print(val.toString());
      setState(() {
        specialtySnapshot = val;
        print(specialtySnapshot);
      });
    });
  }

  Widget doctorList() {
    return doctorSnapshot != null
        ? Container(
            child: SizedBox(
              height: 30,
              width: 30,
              child: ListView.builder(
                  itemCount: doctorSnapshot!.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return doctorCard(
                      firstName: doctorSnapshot!.docs[index]["FirstName"],
                      lastName: doctorSnapshot!.docs[index]["LastName"],
                      prefix: doctorSnapshot!.docs[index]["Prefix"],
                      specialty: doctorSnapshot!.docs[index]["Specialty"],
                      //imagePath: doctorSnapshot.docs[index]["imagePath"],
                      //rank: doctorSnapshot.docs[index]["Rank"],
                    );
                  }),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 20.0,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget specialtyList() {
    return specialtySnapshot != null
        ? Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            // child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: specialtySnapshot.docs.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return specialtyCard(
            //         specialtyName:
            //             specialtySnapshot.docs[index]["specialtyName"],
            //           specialtyDoctorCount: specialtySnapshot.docs[index]["specialtyDoctorCount"],
            //         // specialtyImagePath: specialtySnapshot.docs[index]
            //         //     ["specialtyImagePath"],
            //       );
            //     }),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  viewDoctorProfile({String? lastName}) {
    DatabaseMethods().getDoctorProfile(lastName!);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DoctorProfilePage()));
  }

  @override
  void initState() {
    // getUserInfo();
    getSpecialties();
    paginateDoctors();
    super.initState();
    UserModel.getCurrentOnlineUserInfo(context);
  }

  // getUserInfo() async {
  //   UserProfile.userEmail = (await CheckSharedPreferences.getUserEmailSharedPreference());
  //   databaseMethods.getUserProfile(UserProfile.userEmail).then((val) {
  //     setState(() {
  //       UserProfile.userFirstName = val.docs[0].data()["FirstName"];
  //       // UserProfile.userImagePath = val.docs[0].data()["imagePath"];
  //       userProfileSnapshot = val;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 3.0),
                child: Row(children: [
                  if (Provider.of<UserModel>(context).userInfo?.FirstName !=
                      null)
                    Text(
                      "Hi, " +
                          Provider.of<UserModel>(context).userInfo!.FirstName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                ]),
              ),
              //
              // Padding(
              //   padding: const EdgeInsets.only(left:108.0, top: 5.0),
              //   child: Row(
              //     children: [
              //       Text("Welcome",
              //
              //         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),
              //       ),
              //     ],
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 18.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 160,
                      width: 300,
                      child: Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.2)),
                        shadowColor: Colors.tealAccent,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 25.0),
                                  child: Text(
                                    "Welcome to Total House Clinic\n  ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            // Text("Swipe left\n  ",style: TextStyle( fontSize: 10,fontWeight: FontWeight.bold, color: Colors.blue)
                            //),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(0),
                  ),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  askaquestion()));
                                    },
                                    child: Admin_selection(
                                      image: 'assets/images/consultancy.png',
                                      title: 'Ask a Question',
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorProfilePage()));
                                    },
                                    child: Admin_selection(
                                      image: 'assets/images/lookup.png',
                                      title: 'Doctor Lookup',
                                      ontap: () {
                                        //  initiatePhoneCall('tel:$_phone');
                                      },
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Navigator.of(context).push(MaterialPageRoute(
                                //           builder: (context) => MyHealthPage(email: UserProfile.userEmail,)));
                                //     },
                                //     child: Admin_selection(
                                //       image: 'assets/images/health.png',
                                //       title: 'My Health',
                                //       ontap: () {
                                //         // Navigator.of(context).push(MaterialPageRoute(
                                //         //     builder: (context) => polls()));
                                //       },
                                //     ),
                                //   ),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Admin_selection(
                                    image: 'assets/images/faq.png',
                                    title: 'FAQs',
                                    ontap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => polls()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    sectionTitle(context, "Departments"),
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 200,

                      child: ListView(
                        padding: EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Dentist()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 180,
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/tooth.png",
                                        height: 120),
                                    Center(
                                        child: Text(
                                      "Dentist",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFB3CA2E6),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => pharmacy()));
                              },
                              child: Container(
                                width: 180,
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/pill.png",
                                        height: 60),
                                    Center(
                                        child: Text(
                                      "Pharmacy",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFB3CA2E6),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Gynecology()));
                              },
                              child: Container(
                                width: 180,

                                child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/gyn.png",
                                              height: 80),
                                          Text(
                                  "Gynecology",
                                  style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                ),
                                        ],
                                      ),
                                    )),
                                // color: Colors.white38,
                                decoration: BoxDecoration(
                                  color: Color(0xFFB3CA2E6),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
