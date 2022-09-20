import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:totalclinic/progressdialog.dart';

import 'package:totalclinic/services/database.dart';
import 'package:totalclinic/Pages/signin.dart';

import '../main.dart';

class SignUpPage extends StatefulWidget {
  //  const SignUpPage(void Function() toggleView, {Key key}) : super(key: key);

  static const String idScreen = "signUP";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  User ?firebaseUser;
  User? currentfirebaseUser;
  String? _email, _password, _firstName,_lastname, _mobileNumber;

  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameTextEditingController =
      new TextEditingController();
  TextEditingController lastNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  TextEditingController phoneTextEditingController =
      new TextEditingController();
  String? dateofBirth;
  String? firstName;
  String? lastName;
  int ?phone;
  String? Gender;
  int ?Age;

  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  DateTime? birthDate; // instance of DateTime
  String ?birthDateInString;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return overscroll !=null;
      },
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(
                      //     top: 15.0,
                      //     right: 40.0,
                      //     left: 40.0,
                      //   ),
                      //   child: Text(
                      //     '',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: Color(0xFFFFFFFF),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        // transform:
                        // Matrix4.translationValues(0.0, 60.0, 0.0),
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
                            //firstName
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _firstName = value;
                                },
                                //keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return val!.length > 6 ? null : "First Name";
                                },
                                controller: firstNameTextEditingController,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFb1b2c4),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.05),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 25.0,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: const Color(0xFFF01410),
                                  ),
                                  //
                                ),
                              ),
                            ),
                            //lastName
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _lastname = value;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return val!.length > 6 ? null : "Last Name";
                                },
                                controller: lastNameTextEditingController,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFb1b2c4),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.05),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 25.0,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: const Color(0xFFF01410),
                                  ),
                                  //
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _email = value;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return val!.length > 6
                                      ? null
                                      : "Please enter a valid email address";
                                },
                                controller: emailTextEditingController,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'email@address.com',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFb1b2c4),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.05),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 25.0,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.alternate_email,
                                    color: const Color(0xFFF01410),
                                  ),
                                  //
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _mobileNumber = value;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return val!.length > 6 ? null : "Phone";
                                },
                                controller: phoneTextEditingController,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'Phone',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFb1b2c4),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.05),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 25.0,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: const Color(0xFFF01410),
                                  ),
                                  //
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _password = value;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) {
                                  return val!.length > 6
                                      ? null
                                      : "Password must be greater than 6 characters";
                                },
                                controller: passwordTextEditingController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFb1b2c4),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.05),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: const Color(0xFFF01410),
                                  ),
                                  //
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  final datePick = await showDatePicker(
                                      context: context,
                                      initialDate: new DateTime.now(),
                                      firstDate: new DateTime(1900),
                                      lastDate: new DateTime(2100));
                                  if (datePick != null &&
                                      datePick != birthDate) {
                                    setState(() {
                                      birthDate = datePick;
                                      isDateSelected = true;
                                      birthDateInString =
                                          "${birthDate!.month}/${birthDate!.day}/${birthDate!.year}";
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      new Icon(
                                        Icons.calendar_today,
                                        color: const Color(0xFFF01410),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                          (isDateSelected
                                              ? DateFormat.yMMMd()
                                                  .format(birthDate!)
                                              : initValue),
                                          style: TextStyle(
                                            color: const Color(0xFFb1b2c4),
                                          ),
                                        ),
                                      )
                                    ],
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 30, right: 30),
                                child: DropdownButton(
                                  hint: Gender == null
                                      ? Text('Gender')
                                      : Text(
                                          Gender!,
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: Colors.blue),
                                  items:
                                      ['Male', 'Female', 'Rather Not Say'].map(
                                    (Genderval) {
                                      return DropdownMenuItem<String>(
                                        value: Genderval,
                                        child: Text(Genderval),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        Gender = val.toString();
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child:ElevatedButton(
                    // color: const Color(0xFFF01410),
                    // padding: EdgeInsets.all(15),
                    onPressed: () => [
                      if (firstNameTextEditingController.text.length < 0)
                        {
                          displayToast(
                              "First Name must be at least 3 characters.", context),
                        }
                      else if(lastNameTextEditingController.text.length<0)
                        {
                          displayToast(
                              "Last Name must be at least 3 characters.", context),

                        }
                      else if (!emailTextEditingController.text.contains("@"))
                        {
                          displayToast("Email address is not Valid", context),
                        }
                      else if (phoneTextEditingController.text.isEmpty)
                        {
                          displayToast("PhoneNumber are mandatory", context),
                        }
                      //
                      else if (passwordTextEditingController.text.length < 6)
                        {
                          displayToast(
                              "Password must be atleast 6 Characters", context),
                        }
                      else
                        {
                       registerNewUser(context),
                          registerInfirestore(context),


                        }
                    ],
                    //textColor: Colors.white,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30.0),
                    // ),
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
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Already have an account? Sign In instead.',
                        style: TextStyle(
                            color: Color(0xFFb1b2c4),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SignInPage();
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering,Please wait.....",
          );
        });
    registerInfirestore(context);

    firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) // user created

    {
      //save use into to database

      Map userDataMap = {
        "firstName": firstNameTextEditingController.text.trim(),
        "lastName": lastNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "fullName": firstNameTextEditingController.text.trim()  +lastNameTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        // "Dob":birthDate,
        // "Gender":Gender,
      };
      clients.child(firebaseUser!.uid).set(userDataMap);
      // Admin.child(firebaseUser!.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displayToast("Congratulation, your account has been created", context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInPage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return SignInPage();
        }),
      );
      // Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }

  Future<void> registerInfirestore(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null) {
      FirebaseFirestore.instance.collection('Clients').doc(_email).set({
        'firstName': _firstName,
        'lastName': _lastname,
        'MobileNumber': _mobileNumber,
        'fullName': _firstName !+ _lastname!,
        'Email': _email,
        'Gender': Gender,
        'Date Of Birth': birthDate,
      });
    }
      print("Registered");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return SignInScreen();
      //   }),
      // );


  }

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
