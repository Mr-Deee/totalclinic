import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DoctorDatabase.dart';
import '../imageGallery.dart';
import '../main.dart';
import '../models/DoctorUserProfile.dart';
import '../widgets.dart';

DocumentSnapshot? snapshot;

class DoctorProfilePage extends StatefulWidget {
  // final String ?lastName;
  BuildContext? context;

  //
  // DoctorProfilePage(String lastName);
  //
  // DoctorProfilePage(this.lastName);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  List<DoctorUserModel> DModel = [];
  String? lastName;

  // _DoctorProfilePageState(this.lastName);

  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot? doctorProfileSnapshot;
  QuerySnapshot? doctorOfficeSnapshot;

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
      DModel.add(DoctorUserModel.fromMap(
          Map<String, dynamic>.from(event.snapshot.value as dynamic)));
    });
  }

  _onEntryChanged(DatabaseEvent event) {
    var old = DModel.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      DModel[DModel.indexOf(old)] = DoctorUserModel.fromMap(
          Map<String, dynamic>.from(event.snapshot.value as dynamic));
    });
  }

  Widget doctorProfile() {
    return doctorProfileSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: doctorProfileSnapshot!.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return doctorCard(
                    firstName: doctorProfileSnapshot!.docs[index]["FirstName"],
                    lastName: doctorProfileSnapshot!.docs[index]["LastName"],
                    prefix: doctorProfileSnapshot!.docs[index]["Prefix"],
                    specialty: doctorProfileSnapshot!.docs[index]["Specialty"],
                    //imagePath: doctorProfileSnapshot.docs[index]["imagePath"],
                    rank: doctorProfileSnapshot!.docs[index]["Rank"],
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

  doctorCard({
    String? firstName,
    String? lastName,
    String? prefix,
    String? specialty,
    //String? imagePath,
    num? rank,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
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
      alignment: Alignment.center, // where to position the child
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
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
                  //transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            color: Theme.of(context).primaryColor,
                            highlightColor: Theme.of(context).primaryColorLight,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Icon(
                              Icons.phone,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Office',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 15.0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            transform:
                                Matrix4.translationValues(0.0, -15.0, 0.0),
                            child: CircleAvatar(
                              radius: 40,
                              child: ClipOval(
                                  // child: CachedNetworkImage(
                                  //   imageUrl: imagePath,
                                  //   imageBuilder: (context, imageProvider) =>
                                  //       Container(
                                  //     decoration: BoxDecoration(
                                  //       image: DecorationImage(
                                  //         image: imageProvider,
                                  //         fit: BoxFit.cover,
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   placeholder: (context, url) =>
                                  //       CircularProgressIndicator(),
                                  //   errorWidget: (context, url, error) =>
                                  //       Image.asset('assets/images/user.jpg'),
                                  // ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => ChatsPage(),
                              // ));
                            },
                            color: Theme.of(context).primaryColor,
                            highlightColor: Theme.of(context).primaryColorLight,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.mail_outline,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Message',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${prefix} '
                                  '${firstName} '
                                  '${lastName}' ??
                              "lastName not found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF6f6f6f),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           CategoryPage(specialty)),
                            // );
                          },
                          child: Text(
                            specialty ?? "specialty not found",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Doctors",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,

          alignment: Alignment.center, // where to position the child
          child: SizedBox(
            height: 300,
            child: Row(
              children: [
                Flexible(
                  child: FirebaseAnimatedList(
                    query: Doctor,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 100,
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                  elevation: 0.8,
                                  //shadowColor: Colors.grey,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      side: BorderSide(
                                          width: 2, color: Colors.white24)),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                                  offset:
                                                                      const Offset(
                                                                          0,
                                                                          10))
                                                            ],
                                                            shape:
                                                                BoxShape.circle,
                                                            // image: const DecorationImage(
                                                            //     fit: BoxFit.cover,
                                                            //     image: NetworkImage(
                                                            //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                                            //     )
                                                            // )
                                                          ),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            radius: 70,
                                                            backgroundImage: DModel[
                                                                            index]
                                                                        .profileImage
                                                                        .toString() !=
                                                                    null
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
                                                            style: TextStyle(
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
                                                                      .all(2.0),
                                                              child: Text(
                                                                DModel[index]
                                                                    .Specialty
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              SizedBox(
                                                                width: 70.0,
                                                                height: 50.0,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                24.0),
                                                                        side: const BorderSide(
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                  // color: Colors.white,
                                                                  //  shape: RoundedRectangleBorder(
                                                                  //      borderRadius:
                                                                  //      BorderRadius.circular(
                                                                  //          24.0),
                                                                  //      side: const BorderSide(
                                                                  //          color:
                                                                  //          Colors.white)),
                                                                  onPressed:
                                                                      () async {
                                                                    showDialog<
                                                                        void>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      // user must tap button!
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text('About'),
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  'Biography',
                                                                                  style: TextStyle(color: Colors.black12),
                                                                                ),
                                                                                Text(
                                                                                  'I am a ' + "${DModel[index].Specialty.toString()},",
                                                                                  style: TextStyle(color: Colors.black54),
                                                                                ),
                                                                                Text(
                                                                                  'Work-Days: ' + "",
                                                                                  style: TextStyle(color: Colors.black54),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              child: Text(
                                                                                'close',
                                                                                style: TextStyle(color: Colors.red),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            1.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: const [
                                                                        Icon(
                                                                          Icons
                                                                              .info,
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
                            ),
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
//
// _showpopup(context )

// );
