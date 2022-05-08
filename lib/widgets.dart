import 'dart:core';
import 'dart:core';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:totalclinic/search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

import 'DoctorDatabase.dart';
import 'Pages/DoctorProfile.dart';
import 'category.dart';
import 'main.dart';
import 'models/userProfile.dart';
import 'models/user_model.dart';
import 'myHealth.dart';

DocumentSnapshot snapshot;

class GlobalAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text("Total House",style:TextStyle(fontSize: 26))),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE60000),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(35);
}

class StandardAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class GlobalDrawer extends StatefulWidget {
  @override
  _GlobalDrawerState createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorSnapshot;
  QuerySnapshot specialtySnapshot;

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getSpecialties() async {
    databaseMethods.getAllSpecialties().then((val) {
      setState(() {
        specialtySnapshot = val;
      });
    });
  }

  User user;
  UserModel userModel;
  DatabaseReference userRef;

  Future<String> _getUserDetails() async {
    DatabaseEvent event = await userRef.once();

    userModel =
        UserModel.fromMap(Map<String, dynamic>.from(event.snapshot.value));

    // setState(() {});
  }

  Widget specialtyList() {
    return specialtySnapshot != null
        ? MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: specialtySnapshot.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return specialtyDrawerItem(
                    specialtyName: specialtySnapshot.docs[index]
                        ["specialtyName"],
                    specialtyDoctorCount: specialtySnapshot.docs[index]
                        ["specialtyDoctorCount"],
                    specialtyImagePath: specialtySnapshot.docs[index]
                        ["specialtyImagePath"],
                  );
                },
              ),
            ),
          )
        : Text("error");
  }

  Widget specialtyDrawerItem(
      {String specialtyName,
      String specialtyDoctorCount,
      String specialtyImagePath}) {
    return ListTile(
      leading: Image.network(
        specialtyImagePath,
        height: 25,
        width: 25,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(specialtyName ?? "not_found"),
          Container(
            width: 35,
            height: 35,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0x156aa6f8)),
            child: Align(
              alignment: Alignment.center,
              child: Text(specialtyDoctorCount ?? "0"),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(specialtyName),
            ));
      },
    );
  }

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userRef = FirebaseDatabase.instance
          .reference()
          .child('Clients')
          .child(user.uid);
      userRef.keepSynced(true);
    }
    getSpecialties();

    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Out'),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Are you certain you want to Sign Out?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  print('yes');
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                  // Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
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
    }

    return Drawer(
        child: ListView(
            shrinkWrap: true,
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
          Container(
              height: 170.0,
              decoration: BoxDecoration(
                color: Color(0xFFE60000),
              ),
              child: DrawerHeader(
                child: Row(
                  children: [
                    new Container(
                      margin: EdgeInsets.only(
                        right: 15.0,
                      ),
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                          child: CachedNetworkImage(
                        imageUrl: UserProfile.userImagePath,
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
                      )),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Column(children: [
                            Text(
                              '',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            if (Provider.of<UserModel>(context)
                                    .userInfo
                                    ?.FirstName !=
                                null)
                              Text(
                                Provider.of<UserModel>(context)
                                    .userInfo
                                    .FirstName,

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFFFFFFFF),
                                ), // snapshot.data  :- get your object which is pass from your downloadData() function
                              )
                          ])),
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Text(
                              'How can we help you today?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xAAFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite_border),
                      title: Text('My Health'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHealthPage(UserProfile.userFirstName)),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.people),
                      title: Text('All Doctors'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                    ),
                    ExpansionTile(
                      leading: Icon(Icons.mood),
                      title: Text("Browse by Specialty"),
                      children: <Widget>[
                        specialtyList(),
                      ],
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Logout'),
                      onTap: () {
                        //authMethods.signOut();
                        _showMyDialog();

                      },
                    ),
                  ],
                ),
              ))
        ]));
  }
}

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

Future<String> someFutureStringFunction() async {
  return Future.delayed(const Duration(seconds: 1), () => "someText");
}

class StarRating extends StatelessWidget {
  final int starCount;
  final num rating;
  final Color color;
  final MainAxisAlignment rowAlignment;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.color,
    this.rowAlignment = MainAxisAlignment.center,
  });

  Widget buildStar(
      BuildContext context, int rank, MainAxisAlignment rowAlignment) {
    Icon icon;
    if (rank >= rating) {
      return icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (rank > rating - 1 && rank < rating) {
      return icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      return icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: rowAlignment,
      children: new List.generate(
        starCount,
        (rank) => buildStar(context, rank, rowAlignment),
      ),
    );
  }
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}

Widget myHealthTextField({String hintText, String initialValue}) {
  // new
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: TextFormField(
      textAlign: TextAlign.end,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        prefix: Padding(
          padding: EdgeInsets.only(
            right: 15,
          ),
          child: Text(
            hintText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '';
        }
        return null;
      },
    ),
  );
}

Widget imageDialog(context, imageUrl) {
  return Dialog(
    child: Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(imageUrl), fit: BoxFit.cover)),
    ),
  );
}

Widget customTextField(context, String hintText, IconData icon) {
  return TextField(
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color(0xFFb1b2c4),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(60),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(60),
      ),
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 25.0,
      ),
      prefixIcon: Icon(
        icon,
        color: Color(0xFF6aa6f8),
      ),
      //
    ),
    style: TextStyle(color: Colors.white),
  );
}

Widget myHealthCoverages(String coverageName, IconData coverageIcon) {
  return FractionallySizedBox(
    widthFactor: 0.33,
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.only(
          right: 15.0,
          bottom: 15.0,
        ),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFFe9f0f3),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                coverageIcon,
                size: 35,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 7.5,
                ),
                child: Text(
                  coverageName,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget myHealthScore(double userHealthScore, context) {
  return Container(
    child: Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFe9f0f3),
      ),
      child: Center(
        child: AnimatedFlipCounter(
          duration: Duration(milliseconds: 500),
          value: userHealthScore ?? 1,
          /* pass in a number like 2014 */
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    ),
  );
}

Widget sectionTitle(context, String title) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Divider(
            color: Colors.black12,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}

Widget doctorCard(
    {String firstName,
    String lastName,
    String prefix,
    String specialty,
    String imagePath,
    num rank,
    BuildContext context}) {
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 10.0,
    ),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DoctorProfilePage(),
            ),
          );
        },
        child: Container(
          child: Align(
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 20.0,
                    ),
                    child: ClipOval(
                      child: imagePath != null
                          ? CachedNetworkImage(
                              imageUrl: imagePath,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 70.0,
                                height: 72.5,
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '${prefix} '
                            '${firstName} '
                            '${lastName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF6f6f6f),
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
                              specialty,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9f9f9f),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5.0,
                            ),
                            // child: StarRating(
                            //   rating: rank,
                            //   rowAlignment: MainAxisAlignment.start,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// extension StringExtension on String {
//   // String capitalize() {
//   //   return "${this.toUpperCase()}${this.substring(1)}";
//   // }
// }
