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
import 'package:totalclinic/search.dart';
import 'package:totalclinic/services/shared_preferences.dart';
import 'package:totalclinic/widgets.dart';
import 'package:totalclinic/widgets/AdminSelection.dart';

import '../category.dart';
import '../functions.dart';
import '../models/userProfile.dart';
import '../models/user_model.dart';
import '../myHealth.dart';
import 'PersonalData.dart';

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
   DatabaseReference userRef;
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
   _getUserDetails(BuildContext context) async {
     DatabaseEvent event = await userRef.once();

     context.read<UserModel>().setUser(UserModel.fromMap(Map<String, dynamic>.from(event.snapshot.value)));

     // setState(() {});
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

  // Widget loadUserInfo() {
  //   return userModel.FirstName != null
  //       ? Container(
  //
  //           child: userHeader(
  //             firstName: userModel.FirstName,
  //             // imagePath: userProfileSnapshot.docs[0]["imagePath"],
  //             //email: userProfileSnapshot.docs[0]["Email"],
  //           ),
  //         )
  //       :
  //      Container(
  //           height: 30,
  //
  //           alignment: Alignment.center,
  //           child: CircularProgressIndicator(
  //             valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
  //           ),
  //         );
  // }

  Widget userHeader({
    String firstName,
    String email,
    String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30.0,
        left: 20.0,
        right: 20.0,
        bottom: 25.0,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 25.0,
            ),
            width: 70.0,
            height: 70.0,
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 0),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: imagePath != null
                  ? CachedNetworkImage(
                      imageUrl: imagePath,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/user.jpg'),
                    )
                  : (Container()),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    'Welcome back, ' + titleCase(firstName),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.25,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Text(
                      'How can we help you today?',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorList() {
    return doctorSnapshot != null
        ? Container(
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
                    imagePath: doctorSnapshot.docs[index]["imagePath"],
                    rank: doctorSnapshot.docs[index]["Rating"],
                  );
                }),
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
                    specialtyImagePath: specialtySnapshot.docs[index]
                        ["specialtyImagePath"],
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
      String specialtyDoctorCount,
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
                          child: Image.network(
                            specialtyImagePath,
                            height: 60,
                            width: 60,
                          ),
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
          MaterialPageRoute(builder: (context) => DoctorProfilePage(lastName)));
  }

  @override
  void initState() {

    getUserInfo();
    getSpecialties();
    paginateDoctors();
    super.initState();

    _getUserDetails(context);

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
      drawer: GlobalDrawer(),
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
              // loadUserInfo(),
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
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 15.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
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
                    sectionTitle(context, "Our Top Doctors"),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 15.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' .',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          loadedDoctors.length == null
                              ? Center(
                                  child: Text('No More Data to load...'),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: loadedDoctors.length,
                                  itemBuilder: (context, index) {
                                    return doctorCard(
                                      context: context,
                                      firstName: doctorSnapshot.docs[index]
                                          ["firstName"],
                                      lastName: doctorSnapshot.docs[index]
                                          ["lastName"],
                                      prefix: doctorSnapshot.docs[index]["prefix"],
                                      specialty: doctorSnapshot.docs[index]
                                        ["specialty"],
                                      imagePath: doctorSnapshot.docs[index]["imagePath"],
                                      rank: doctorSnapshot.docs[index]
                                          ["rank"],
                                    );
                                  },
                                ),
                          isLoading
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(5),
                                  color: Colors.yellowAccent,
                                  child: Text(
                                    'Loading',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0,
                      ),
                      child: RaisedButton(
                        color: Color(0xFF4894e9),
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                          paginateDoctors();
                        },
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'View More',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }


}
