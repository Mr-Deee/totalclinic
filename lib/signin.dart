
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:totalclinic/SignUpPage.dart';
import 'package:totalclinic/progressdialog.dart';
import 'package:totalclinic/services/authentication.dart';
import 'package:totalclinic/services/database.dart';
import 'package:totalclinic/services/shared_preferences.dart';

import 'home.dart';
import 'main.dart';

class SignInPage extends StatefulWidget {
  static const String idScreen = "signUP";
  //const SignInPage(void Function() toggleView, {Key key, this.toggleView}) : super(key: key);
  // final Function toggleView;
  // SignInPage(this.toggleView);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  String _email, _password;
  TextEditingController emailTextEditingController =
  new TextEditingController();
  TextEditingController passwordTextEditingController =
  new TextEditingController();
  AuthMethods authService = new AuthMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool incorrectLogin = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text)
          .then((result) async {
        incorrectLogin = false;
        if (result != null) {
          QuerySnapshot userInfoSnapshot = await DatabaseMethods()
              .getUserInfo(emailTextEditingController.text);
          CheckSharedPreferences.saveUserLoggedInSharedPreference(true);
          CheckSharedPreferences.saveNameSharedPreference(
              userInfoSnapshot.docs[0]["name"] );
          CheckSharedPreferences.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0]["email"]);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          setState(() {
            isLoading = false;
            incorrectLogin = true;
            debugPrint("WRONG");
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
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
                              padding: const EdgeInsets.only(top:80.0),
                              child: Image.asset(
                                "assets/images/l.png",

                              ),
                            ),
                          ),

                          Container(
                            transform:
                            Matrix4.translationValues(0.0, 10.0, 0.0),
                            margin: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
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
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Please enter a valid email address";
                                    },
                                    controller: emailTextEditingController,
                                    onChanged: (value) {
                                      _email=value;
                                    },
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
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      prefixIcon: Icon(
                                        Icons.alternate_email,
                                        color:  const Color(0xFFF01410),
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
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Password must be greater than 6 characters";
                                    },
                                    controller: passwordTextEditingController,
                                    obscureText: true,
                                    onChanged: (value) {
                                      _password=value;
                                    },
                                    decoration: InputDecoration(
                                      errorText: incorrectLogin == true
                                          ? 'Password or Email wrong, please try again'
                                          : null,
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
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color:  const Color(0xFFF01410),
                                      ),
                                      //
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
                      child: RaisedButton(
                        color:  const Color(0xFFF01410),
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                          loginAndAuthenticateUser(context);
                        },
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Need an account? Create one instead.',
                            style: TextStyle(
                                color:  Color(0xFFb1b2c4),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpPage();
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


  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Logging you ,Please wait.",);
        }


    );

    Future signInWithEmailAndPassword(String email, String password) async {
      try {
        UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        User user = result.user;
        return _firebaseAuth;
      } catch (error) {
        print(error.toString());
        return null;
      }
    }


    final User firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim()
    ).catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    })).user;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim());


      if (clients != null) {
        Navigator.of(context).pushNamed(HomeScreen.idScreen);


        displayToast("Logged-in ",
            context);
      } else {
        displayToast("Error: Cannot be signed in", context);
      }

      //final User? firebaseUser = userCredential.user;
      // if (firebaseUser != null) {
      //   final DatabaseEvent event = await
      //   //Admin.child(firebaseUser.uid).once();
      //   BoardMembers.child(firebaseUser.uid).once();
      //   // if (event.snapshot.value !=Admin) {
      //   //   Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen,
      //   //           (route) => false);
      //   //   displayToast("Logged-in As Admin", context);
      //   // }
      //   if(event.snapshot.value !=BoardMembers){
      //     Navigator.pushNamedAndRemoveUntil(context, VotersScreen.idScreen,
      //             (route) => false);
      //     displayToast("Logged-in As Board Member",
      //         context);
      //    // await _firebaseAuth.signOut();
      //   }

    } catch (e) {
      // handle error
    }





  }
  //
  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);

// user created

  }
}
