import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:totalclinic/DoctorDatabase.dart';
import 'package:totalclinic/Pages/DoctorProfile.dart';
import 'package:totalclinic/Pages/SignUpPage.dart';
import 'package:totalclinic/Pages/askquestion.dart';
import 'package:totalclinic/components/drawer/custom_drawer.dart';
import 'package:totalclinic/search.dart';
import 'package:totalclinic/services/shared_preferences.dart';
import 'package:totalclinic/widgets.dart';
import 'package:totalclinic/widgets/AdminSelection.dart';
import 'package:totalclinic/widgets/SpecialtySelection.dart';

import '../category.dart';
import '../functions.dart';
import '../models/userProfile.dart';
import '../models/user_model.dart';
import '../myHealth.dart';
import '../models/DoctorUserProfile.dart';

DocumentSnapshot snapshot;

class HomeScreen extends StatefulWidget {
  static const String idScreen = "HomePage";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



DatabaseReference _ref;


 class _HomeScreenState extends State<HomeScreen> {


   User user;
   UserModel userModel;
   DatabaseReference Clients;
  Future<void> _launched;
  String _phone = '123-456-7890';
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorSnapshot;
  QuerySnapshot specialtySnapshot;
  QuerySnapshot doctorSpecialtyCount;
  QuerySnapshot userProfileSnapshot;
  List<DocumentSnapshot> loadedDoctors = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 1;
  DocumentSnapshot lastDocument;

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



  Widget userHeader({
    String firstName,
    String email,
    String imagePath,
  })
  {

  }

  Widget doctorList() {
    return doctorSnapshot != null
        ? Container(
            child: SizedBox(
              height: 30,
              width: 30,
              child: ListView.builder(
                  itemCount: doctorSnapshot.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return doctorCard(
                      firstName: doctorSnapshot.docs[index]["FirstName"],
                      lastName: doctorSnapshot.docs[index]["LastName"],
                      prefix: doctorSnapshot.docs[index]["Prefix"],
                      specialty: doctorSnapshot.docs[index]["Specialty"],
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: specialtySnapshot.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return specialtyCard(
                    specialtyName:
                        specialtySnapshot.docs[index]["specialtyName"],
                      specialtyDoctorCount: specialtySnapshot.docs[index]
                         ["specialtyDoctorCount"],
                    // specialtyImagePath: specialtySnapshot.docs[index]
                    //     ["specialtyImagePath"],
                  );
                }),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget specialtyCard(
      {String specialtyName,
       specialtyDoctorCount,
      String specialtyImagePath}) {
    return Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          bottom: 10.0,
        ),
        width: 135,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          color: Colors.white,
          child: new InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryPage(specialtyName)),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 5.0,
                            bottom: 12.5,
                          ),
                          // child: Image.network(
                          //   specialtyImagePath,
                          //   height: 60,
                          //   width: 60,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      specialtyName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6f6f6f),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 3.0,
                      ),
                      child: Text(
                        specialtyDoctorCount + ' Doctors',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF9f9f9f),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  viewDoctorProfile({String lastName}) {
    DatabaseMethods().getDoctorProfile(lastName);
    Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DoctorProfilePage()));
  }

  @override
  void initState() {

    getUserInfo();
    getSpecialties();
    paginateDoctors();
    super.initState();
    UserModel.getCurrentOnlineUserInfo(context);

  }

  getUserInfo() async {
    UserProfile.userEmail =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    databaseMethods.getUserProfile(UserProfile.userEmail).then((val) {
      setState(() {
        // userFirstName = val.docs[0].data()["firstName"];
        // UserProfile.userImagePath = val.docs[0].data()["imagePath"];
        userProfileSnapshot = val;
      });
    });
  }

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
            color:
            Color(0xFFE60000),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left:30.0),
              //   child: Row(
              //     children: [
              //       if (Provider.of<UserModel>(context).userInfo?.FirstName != null)
              //       Text(
              //         "Welcome"+" "+Provider.of<UserModel>(context).userInfo.FirstName+"!",
              //
              //         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
              //       ),
              //
              //
              //
              //
              //     ],
              //   ),
              // ),



              SizedBox(height: 20,),

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
                            scrollDirection:Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [



                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => askaquestion()));
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
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUpPage()));
                                    },
                                    child: Admin_selection(
                                      image: 'assets/images/lifestyle.png',
                                      title: 'LifeStyle',


                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // initiatePhoneCall('tel:$_phone');
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => polls()));
                                    },
                                    child: Admin_selection(

                                      image: 'assets/images/lookup.png',
                                      title: 'Doctor Lookup',
                                      ontap: () {
                                        // initiatePhoneCall('tel:$_phone');
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => polls()));
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Admin_selection(
                                    image: 'assets/images/health.png',
                                    title: 'My Health',
                                    ontap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => polls()));
                                    },
                                  ),
                                ),

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

                  sectionTitle(context, "Specialties"),


                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 180,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          specialtyList(),
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
