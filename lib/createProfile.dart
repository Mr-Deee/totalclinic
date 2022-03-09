import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:totalclinic/services/authentication.dart';

import 'home.dart';
import 'services/database.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController FirstNameTextEditingController =
      new TextEditingController();
  TextEditingController LastNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signUpAccount() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "FirstName": FirstNameTextEditingController.text,
        "LastName": LastNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunctions.saveUserNamePreference(
          FirstNameTextEditingController.text);
      HelperFunctions.saveUserEmailPreference(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        // print("${val.uid}");

        databaseMethods.setUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    decoration: BoxDecoration(

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(



                          child: Text(
                            'Create Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 15.0,
                            right: 40.0,
                            left: 40.0,
                          ),
                          child: Text(
                            'SignUp for Doctors ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, 60.0, 0.0),
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 50.0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.name
                                  ,
                                  validator: (val) {
                                    return val.length > 2
                                        ? null
                                        : "Please enter a first name";
                                  },
                                  controller: FirstNameTextEditingController,
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    hintText: 'first name',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFb1b2c4),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.05),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 25.0,
                                    ),
                                  ),
                                ),
                              ),


                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  validator: (val) {
                                    return val.length > 2
                                        ? null
                                        : "Please enter a last name";
                                  },
                                  controller: LastNameTextEditingController,

                                  decoration: InputDecoration(
                                    hintText: 'last name',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFb1b2c4),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.05),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 25.0,
                                    ),
                                  ),
                                ),
                              ),


                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    return val.length > 2
                                        ? null
                                        : "Please enter email";
                                  },
                                  controller: emailTextEditingController,

                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFb1b2c4),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.05),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    return val.length > 2
                                        ? null
                                        : "Please enter a password";
                                  },
                                  controller: passwordTextEditingController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFb1b2c4),
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.05),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 25.0,
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
                  Container(
                    margin: const EdgeInsets.only(
                      top: 90.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        signUpAccount();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
}
