import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:totalclinic/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DoctorDatabase.dart';
import '../category.dart';
import '../imageGallery.dart';
import '../main.dart';
import '../models/DoctorUserProfile.dart';

DocumentSnapshot snapshot;

class DoctorProfilePage extends StatefulWidget {
 // final String lastName;
  BuildContext context;

  //DoctorProfilePage(String lastName);

  // DoctorProfilePage(this.lastName);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  List<DoctorUserModel> DModel = [];
  String lastName;

 // _DoctorProfilePageState(this.lastName);

  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorProfileSnapshot;
  QuerySnapshot doctorOfficeSnapshot;

  getProfile(lastName) async {
    databaseMethods.getDoctorProfile(lastName).then((val) {
      databaseMethods.getDoctorOfficeGallery(lastName).then((officeVal) {
        print(val.toString());
        setState(() {
          doctorProfileSnapshot = val;
          doctorOfficeSnapshot = officeVal;
        });
      });
    });
  }

  @override
  void initState() {
    getProfile(lastName);
    Doctor.onChildAdded.listen(_onEntryAdded);
    Doctor.onChildAdded.listen(_onEntryChanged);
  }
  _onEntryAdded(DatabaseEvent event) {
    setState(() {
      DModel.add(DoctorUserModel.fromMap(Map<String, dynamic>.from(event.snapshot.value as dynamic)));
    });
  }

  _onEntryChanged(DatabaseEvent event) {
    var old = DModel.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      DModel[DModel.indexOf(old)] =
          DoctorUserModel.fromMap(Map<String, dynamic>.from(event.snapshot.value as dynamic));
    });
  }

  Widget doctorProfile() {
    return doctorProfileSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: doctorProfileSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return doctorCard(
                    firstName: doctorProfileSnapshot.docs[index]["FirstName"],
                    lastName: doctorProfileSnapshot.docs[index]["LastName"],
                    prefix: doctorProfileSnapshot.docs[index]["Prefix"],
                    specialty: doctorProfileSnapshot.docs[index]["Specialty"],
                    //imagePath: doctorProfileSnapshot.docs[index]["imagePath"],
                    rank: doctorProfileSnapshot.docs[index]["Rank"],
                    // medicalEducation: doctorProfileSnapshot.docs[index]["medicalEducation"],
                    // residency:
                    //     doctorProfileSnapshot.docs[index]["residency"],
                    // internship:
                    //     doctorProfileSnapshot.docs[index]["internship"],
                    // fellowship:
                    //     doctorProfileSnapshot.docs[index]["fellowship"],
                    // biography:
                    //     doctorProfileSnapshot.docs[index]["biography"],
                  );
                }),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark,
                ], // whitish to gray
              ),
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
  }

  Widget doctorCard({
    String firstName,
    String lastName,
    String prefix,
    String specialty,
    String imagePath,
    num rank,
    String medicalEducation,
    String residency,
    String internship,
    String fellowship,
    String biography,
  }) {
   
    // return Container(
    //   width: MediaQuery.of(context).size.width * 1.0,
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment(-1.0, 0.0),
    //       end: Alignment(1.0, 0.0),
    //       colors: [
    //         Theme.of(context).primaryColorLight,
    //         Theme.of(context).primaryColorDark,
    //       ], // whitish to gray
    //     ),
    //   ),
    //   alignment: Alignment.center, // where to position the child
    //   child: Column(
    //     children: [
    //       // Container(
    //       //   margin: const EdgeInsets.only(
    //       //     top: 15.0,
    //       //   ),
    //       //   decoration: new BoxDecoration(
    //       //     borderRadius: BorderRadius.only(
    //       //       topLeft: Radius.circular(25),
    //       //       topRight: Radius.circular(25),
    //       //     ),
    //       //     color: Color(0xFFFFFFFF),
    //       //     boxShadow: [
    //       //       new BoxShadow(
    //       //         color: Colors.black12,
    //       //         blurRadius: 20.0,
    //       //         offset: Offset(0, 0),
    //       //       ),
    //       //     ],
    //       //   ),
    //       //   child: Column(
    //       //     mainAxisSize: MainAxisSize.min,
    //       //     children: [
    //       //       Container(
    //       //         //transform: Matrix4.translationValues(0.0, -16.0, 0.0),
    //       //         child: Row(
    //       //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       //           children: [
    //       //             Column(
    //       //               children: [
    //       //                 MaterialButton(
    //       //                   color: Theme.of(context).primaryColor,
    //       //                   highlightColor: Theme.of(context).primaryColorLight,
    //       //                   textColor: Colors.white,
    //       //                   onPressed: () {},
    //       //                   child: Icon(
    //       //                     Icons.phone,
    //       //                     size: 30,
    //       //                   ),
    //       //                   padding: EdgeInsets.all(16),
    //       //                   shape: CircleBorder(),
    //       //                 ),
    //       //                 Container(
    //       //                   margin: const EdgeInsets.only(
    //       //                     top: 10.0,
    //       //                   ),
    //       //                   child: Text(
    //       //                     'Office',
    //       //                     textAlign: TextAlign.center,
    //       //                     style: TextStyle(
    //       //                       fontWeight: FontWeight.bold,
    //       //                       fontSize: 15,
    //       //                       color: Color(0xFF6f6f6f),
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //               ],
    //       //             ),
    //       //             Column(
    //       //               children: [
    //       //                 Container(
    //       //                   decoration: BoxDecoration(
    //       //                     borderRadius: BorderRadius.all(
    //       //                       Radius.circular(100),
    //       //                     ),
    //       //                     boxShadow: [
    //       //                       new BoxShadow(
    //       //                         color: Colors.black12,
    //       //                         blurRadius: 15.0,
    //       //                         offset: Offset(0, 0),
    //       //                       ),
    //       //                     ],
    //       //                   ),
    //       //                   transform:
    //       //                       Matrix4.translationValues(0.0, -15.0, 0.0),
    //       //                   child: CircleAvatar(
    //       //                     radius: 40,
    //       //                     child: ClipOval(
    //       //                         // child: CachedNetworkImage(
    //       //                         //   imageUrl: imagePath,
    //       //                         //   imageBuilder: (context, imageProvider) =>
    //       //                         //       Container(
    //       //                         //     decoration: BoxDecoration(
    //       //                         //       image: DecorationImage(
    //       //                         //         image: imageProvider,
    //       //                         //         fit: BoxFit.cover,
    //       //                         //       ),
    //       //                         //     ),
    //       //                         //   ),
    //       //                         //   placeholder: (context, url) =>
    //       //                         //       CircularProgressIndicator(),
    //       //                         //   errorWidget: (context, url, error) =>
    //       //                         //       Image.asset('assets/images/user.jpg'),
    //       //                         // ),
    //       //                         ),
    //       //                   ),
    //       //                 ),
    //       //               ],
    //       //             ),
    //       //             Column(
    //       //               children: [
    //       //                 MaterialButton(
    //       //                   onPressed: () {
    //       //                     // Navigator.of(context).push(MaterialPageRoute(
    //       //                     //   builder: (context) => ChatsPage(),
    //       //                     // ));
    //       //                   },
    //       //                   color: Theme.of(context).primaryColor,
    //       //                   highlightColor: Theme.of(context).primaryColorLight,
    //       //                   textColor: Colors.white,
    //       //                   child: Icon(
    //       //                     Icons.mail_outline,
    //       //                     size: 30,
    //       //                   ),
    //       //                   padding: EdgeInsets.all(16),
    //       //                   shape: CircleBorder(),
    //       //                 ),
    //       //                 Container(
    //       //                   margin: const EdgeInsets.only(
    //       //                     top: 10.0,
    //       //                   ),
    //       //                   child: Text(
    //       //                     'Message',
    //       //                     textAlign: TextAlign.center,
    //       //                     style: TextStyle(
    //       //                       fontWeight: FontWeight.bold,
    //       //                       fontSize: 15,
    //       //                       color: Color(0xFF6f6f6f),
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //               ],
    //       //             ),
    //       //           ],
    //       //         ),
    //       //       ),
    //       //       Container(
    //       //         margin: const EdgeInsets.only(
    //       //           top: 15.0,
    //       //           bottom: 5.0,
    //       //         ),
    //       //         child: Column(
    //       //           children: [
    //       //             Align(
    //       //               alignment: Alignment.center,
    //       //               child: Text(
    //       //                 '${prefix} '
    //       //                         '${firstName} '
    //       //                         '${lastName}' ??
    //       //                     "lastName not found",
    //       //                 style: TextStyle(
    //       //                   fontWeight: FontWeight.bold,
    //       //                   fontSize: 24,
    //       //                   color: Color(0xFF6f6f6f),
    //       //                 ),
    //       //               ),
    //       //             ),
    //       //             Align(
    //       //               alignment: Alignment.center,
    //       //               child: FlatButton(
    //       //                 color: Colors.transparent,
    //       //                 splashColor: Colors.black26,
    //       //                 onPressed: () {
    //       //                   Navigator.push(
    //       //                     context,
    //       //                     MaterialPageRoute(
    //       //                         builder: (context) =>
    //       //                             CategoryPage(specialty)),
    //       //                   );
    //       //                 },
    //       //                 child: Text(
    //       //                   specialty ?? "specialty not found",
    //       //                   style: TextStyle(
    //       //                     fontWeight: FontWeight.bold,
    //       //                     fontSize: 18,
    //       //                     color: Theme.of(context).primaryColor,
    //       //                   ),
    //       //                 ),
    //       //               ),
    //       //             ),
    //       //           ],
    //       //         ),
    //       //       ),
    //       //       Center(
    //       //         child: Align(
    //       //           alignment: Alignment.center,
    //       //           child: StarRating(
    //       //             rating: rank,
    //       //             rowAlignment: MainAxisAlignment.center,
    //       //           ),
    //       //         ),
    //       //       ),
    //       //       biography != null
    //       //           ? sectionTitle(context, "Biography")
    //       //           : Container(),
    //       //       biography != null
    //       //           ? Container(
    //       //               margin: const EdgeInsets.only(
    //       //                 left: 20.0,
    //       //                 right: 20.0,
    //       //               ),
    //       //               child: Align(
    //       //                 alignment: Alignment.centerLeft,
    //       //                 child: Text(
    //       //                   biography ?? "",
    //       //                   style: TextStyle(
    //       //                     color: Color(0xFF9f9f9f),
    //       //                   ),
    //       //                 ),
    //       //               ),
    //       //             )
    //       //           : Container(),
    //       //       // sectionTitle(context, "Physician History"),
    //       //       // Container(
    //       //       //   margin: const EdgeInsets.only(
    //       //       //     left: 20.0,
    //       //       //     right: 20.0,
    //       //       //   ),
    //       //       //   child: Align(
    //       //       //     alignment: Alignment.topCenter,
    //       //       //     child: Row(
    //       //       //       mainAxisAlignment: MainAxisAlignment.start,
    //       //       //       crossAxisAlignment: CrossAxisAlignment.start,
    //       //       //       children: [
    //       //       //         Expanded(
    //       //       //           flex: 5,
    //       //       //           child: Column(
    //       //       //             crossAxisAlignment: CrossAxisAlignment.start,
    //       //       //             children: [
    //       //       //               (medicalEducation != null)
    //       //       //                   ? Container(
    //       //       //                       child: Column(
    //       //       //                         crossAxisAlignment:
    //       //       //                             CrossAxisAlignment.start,
    //       //       //                         mainAxisAlignment:
    //       //       //                             MainAxisAlignment.start,
    //       //       //                         children: [
    //       //       //                           Text(
    //       //       //                             'MEDICAL EDUCATION',
    //       //       //                             style: TextStyle(
    //       //       //                               fontWeight: FontWeight.bold,
    //       //       //                               fontSize: 12,
    //       //       //                               color: Color(0xFF6f6f6f),
    //       //       //                             ),
    //       //       //                           ),
    //       //       //                           Text(
    //       //       //                             medicalEducation,
    //       //       //                             style: TextStyle(
    //       //       //                               color: Color(0xFF9f9f9f),
    //       //       //                             ),
    //       //       //                           )
    //       //       //                         ],
    //       //       //                       ),
    //       //       //                     )
    //       //       //                   : Container(),
    //       //       //               (internship != null)
    //       //       //                   ? Container(
    //       //       //                       margin: EdgeInsets.only(
    //       //       //                         top: 20.0,
    //       //       //                       ),
    //       //       //                       child: Column(
    //       //       //                         crossAxisAlignment:
    //       //       //                             CrossAxisAlignment.start,
    //       //       //                         mainAxisAlignment:
    //       //       //                             MainAxisAlignment.start,
    //       //       //                         children: [
    //       //       //                           Text(
    //       //       //                             'INTERNSHIP',
    //       //       //                             style: TextStyle(
    //       //       //                               fontWeight: FontWeight.bold,
    //       //       //                               fontSize: 12,
    //       //       //                               color: Color(0xFF6f6f6f),
    //       //       //                             ),
    //       //       //                           ),
    //       //       //                           Text(
    //       //       //                             internship,
    //       //       //                             style: TextStyle(
    //       //       //                               color: Color(0xFF9f9f9f),
    //       //       //                             ),
    //       //       //                           )
    //       //       //                         ],
    //       //       //                       ),
    //       //       //                     )
    //       //       //                   : Container(),
    //       //       //             ],
    //       //       //           ),
    //       //       //         ),
    //       //       //         Expanded(
    //       //       //           flex: 5,
    //       //       //           child: Column(
    //       //       //             crossAxisAlignment: CrossAxisAlignment.start,
    //       //       //             children: [
    //       //       //               (residency != null)
    //       //       //                   ? Container(
    //       //       //                       child: Column(
    //       //       //                         crossAxisAlignment:
    //       //       //                             CrossAxisAlignment.start,
    //       //       //                         mainAxisAlignment:
    //       //       //                             MainAxisAlignment.start,
    //       //       //                         children: [
    //       //       //                           Text(
    //       //       //                             'RESIDENCY',
    //       //       //                             style: TextStyle(
    //       //       //                               fontWeight: FontWeight.bold,
    //       //       //                               fontSize: 12,
    //       //       //                               color: Color(0xFF6f6f6f),
    //       //       //                             ),
    //       //       //                           ),
    //       //       //                           Text(
    //       //       //                             residency,
    //       //       //                             style: TextStyle(
    //       //       //                               color: Color(0xFF9f9f9f),
    //       //       //                             ),
    //       //       //                           )
    //       //       //                         ],
    //       //       //                       ),
    //       //       //                     )
    //       //       //                   : Container(),
    //       //       //               (fellowship != null)
    //       //       //                   ? Container(
    //       //       //                       margin: EdgeInsets.only(
    //       //       //                         top: 20.0,
    //       //       //                       ),
    //       //       //                       child: Column(
    //       //       //                         crossAxisAlignment:
    //       //       //                             CrossAxisAlignment.start,
    //       //       //                         mainAxisAlignment:
    //       //       //                             MainAxisAlignment.start,
    //       //       //                         children: [
    //       //       //                           Text(
    //       //       //                             'FELLOWSHIP',
    //       //       //                             style: TextStyle(
    //       //       //                               fontWeight: FontWeight.bold,
    //       //       //                               fontSize: 12,
    //       //       //                               color: Color(0xFF6f6f6f),
    //       //       //                             ),
    //       //       //                           ),
    //       //       //                           Text(
    //       //       //                             fellowship,
    //       //       //                             style: TextStyle(
    //       //       //                               color: Color(0xFF9f9f9f),
    //       //       //                             ),
    //       //       //                           )
    //       //       //                         ],
    //       //       //                       ),
    //       //       //                     )
    //       //       //                   : Container(),
    //       //       //             ],
    //       //       //           ),
    //       //       //         ),
    //       //       //       ],
    //       //       //     ),
    //       //       //   ),
    //       //       // ),
    //       //       // sectionTitle(context, "Office Gallery"),
    //       //       // Container(
    //       //       //   height: 150,
    //       //       //   child: ListView(
    //       //       //     padding: EdgeInsets.zero,
    //       //       //     scrollDirection: Axis.horizontal,
    //       //       //     children: <Widget>[
    //       //       //       officePhotos(context, "https://i.imgur.com/gKdDh8p.jpg"),
    //       //       //       officePhotos(context, "https://i.imgur.com/bJ6gU02.jpg"),
    //       //       //       officePhotos(context, "https://i.imgur.com/ZJZIrIB.jpg"),
    //       //       //       officePhotos(context, "https://i.imgur.com/pTAuS44.jpg"),
    //       //       //       officePhotos(context, "https://i.imgur.com/eY1lW0A.jpg"),
    //       //       //     ],
    //       //       //   ),
    //       //       // ),
    //       //       // sectionTitle(context, "Appointments"),
    //       //       // Container(
    //       //       //   margin: const EdgeInsets.only(
    //       //       //     bottom: 15.0,
    //       //       //   ),
    //       //       //   height: 60,
    //       //       //   // child: ListView(
    //       //       //   //   padding: EdgeInsets.zero,
    //       //       //   //   scrollDirection: Axis.horizontal,
    //       //       //   //   children: <Widget>[
    //       //       //   //     appointmentDays("Monday", "June 15th", context),
    //       //       //   //     appointmentDays("Tuesday", "June 19th`", context),
    //       //       //   //     appointmentDays("Wednesday", "July 24th", context),
    //       //       //   //     appointmentDays("Thursday", "July 12th", context),
    //       //       //   //     appointmentDays("Friday", "July 13th", context),
    //       //       //   //     appointmentDays("Saturday", "August 7th", context),
    //       //       //   //     appointmentDays("Sunday", "August 9th", context),
    //       //       //   //   ],
    //       //       //   // ),
    //       //       // ),
    //       //       // Container(
    //       //       //   margin: const EdgeInsets.only(
    //       //       //     bottom: 15.0,
    //       //       //   ),
    //       //       //   height: 50,
    //       //       //   // child: ListView(
    //       //       //   //   padding: EdgeInsets.zero,
    //       //       //   //   scrollDirection: Axis.horizontal,
    //       //       //   //   children: <Widget>[
    //       //       //   //     appointmentTimes("9:00 AM", context),
    //       //       //   //     appointmentTimes("9:30 AM", context),
    //       //       //   //     appointmentTimes("10:00 AM", context),
    //       //       //   //     appointmentTimes("10:30 AM", context),
    //       //       //   //     appointmentTimes("11:00 AM", context),
    //       //       //   //   ],
    //       //       //   // ),
    //       //       // ),
    //       //     ],
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

        ),
      backgroundColor: Colors.red,),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,

          alignment: Alignment.center, // where to position the child
          child: SizedBox(
            height: 300,
            child: Row(
              children: [  Flexible(
                child: FirebaseAnimatedList(
                  query: Doctor,
                  itemBuilder: (BuildContext context,
                      DataSnapshot snapshot,
                      Animation<double> animation,
                      int index) {
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 100,
                          child: Card(
                              elevation: 0.8,
                              //shadowColor: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  side: BorderSide(
                                      width: 2,
                                      color: Colors.white24)),
                              color: Colors.white,
                              child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0.0),
                                  children: <Widget>[
                                    //Text(Provider.of<OccupationModel>(context).Institution!,style: TextStyle(color: Colors.black),),
                                    Column(children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      width: 80,
                                                      height: 80,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            width: 4,
                                                            color: Theme.of(
                                                                context)
                                                                .scaffoldBackgroundColor),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              spreadRadius:
                                                              2,
                                                              blurRadius:
                                                              10,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                  0.1),
                                                              offset: const Offset(
                                                                  0,
                                                                  10))
                                                        ],
                                                        shape: BoxShape
                                                            .circle,
                                                        // image: const DecorationImage(
                                                        //     fit: BoxFit.cover,
                                                        //     image: NetworkImage(
                                                        //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                                        //     )
                                                        // )




                                                      ),

                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.grey,
                                                        radius: 70,
                                                        backgroundImage:   DModel[index]
                                                            .profileImage
                                                            .toString() != null
                                                            ? NetworkImage(
                                                          DModel[index]
                                                              .profileImage
                                                              .toString(),
                                                        )
                                                            : null,
                                                      )),
                                                  //email

                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(3.0),
                                                      child: Text(
                                                        DModel[index]
                                                            .FirstName
                                                            .toString() +
                                                            " " +
                                                            DModel[index]
                                                                .LastName
                                                                .toString(),
                                                        style:
                                                        TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),

                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(
                                                              2.0),
                                                          child: Text(
                                                            DModel[index]
                                                                .Specialty
                                                                .toString(),
                                                            style:
                                                            TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              15,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Column(
                                                    //   children: [
                                                    //     Text(OModel[
                                                    //     index]
                                                    //         .Education
                                                    //         .toString()),
                                                    //   ],
                                                    // ),

                                                  ],
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            width: 70.0,
                                                            height: 50.0,
                                                            child:
                                                            RaisedButton(
                                                              color: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      24.0),
                                                                  side: const BorderSide(
                                                                      color:
                                                                      Colors.white)),
                                                              onPressed:
                                                                  () async {
                                                                // launch(
                                                                //     ('tel://${DModel[index].phone}'));
                                                              },
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    1.0),
                                                                child:
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceEvenly,
                                                                  children: const [

                                                                    Icon(
                                                                      Icons.call,
                                                                      color:
                                                                      Colors.black,
                                                                      size:
                                                                      26.0,
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ])),

                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                    ])
                                  ])),
                        ));
                  },
                ),
              ),
                // doctorProfile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Material appointmentDays(
    String appointmentDay, String appointmentDate, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 6,
        ),
        onPressed: () {},
        textColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                appointmentDay ?? "error",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                appointmentDate ?? "error",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Material appointmentTimes(String appointmentDay, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        onPressed: () {
          print('View All Doctors Clicked');
        },
        textColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            appointmentDay ?? "error",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget officePhotos(context, String officePhotoUrl) {
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    child: Material(
      child: Ink(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(officePhotoUrl),
          ),
        ),
        child: InkWell(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageGallery(officePhotoUrl)),
            );
          },
          child: Container(
            width: 150.0,
          ),
        ),
      ),
    ),
  );
}
