import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:totalclinic/Authentication/Views/register_user_screen.dart';


import '../../widgets/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../Controller/auth_controller.dart';

class DoctorLoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool incorrectLogin = false;
  String ?_email, _password;
  final authController = Get.find<AuthController>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   centerTitle: true,
      //   title: const Text("Login"),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [



                  Container(

                    child: Padding(
                      padding: const EdgeInsets.only(top:120.0),
                      child: Image.asset(
                        "assets/images/logo.png",

                      ),
                    ),
                  ),
                  Container(
                    transform:
                    Matrix4.translationValues(0.0, 50.0, 0.0),
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
                              return val!.length > 6
                                  ? null
                                  : "Please enter a valid email address";
                            },
                            controller: email,
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
                              return val!.length > 6
                                  ? null
                                  : "Password must be greater than 6 characters";
                            },
                            controller: password,
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

               SizedBox(height: 89,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<AuthController>(builder: (_) {
                        return authController.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : CustomButton(
                          btnTxt: "Login",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              authController.startLoading();
                              await authController.login(
                                  email.text, password.text,context);
                              authController.stopLoading();

                            }
                          },
                        );
                      }),

                      // ElevatedButton(
                      //
                      //   style: ElevatedButton.styleFrom(
                      //   shape:  RoundedRectangleBorder(
                      //
                      //       borderRadius: BorderRadius.circular(20),
                      //
                      // ),
                      //       minimumSize: Size(150, 50),
                      //
                      //       backgroundColor: Colors.green
                      //
                      //
                      //   ),
                      //   onPressed: () {
                      //     Get.toNamed(StudentLogin.routeName);
                      //   },
                      //   child: const Text("Member Login"),
                      // ),
                    ],
                  ),
                  InkWell(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("New User? Signup"),
                    ),
                    onTap: () {
                      Get.toNamed(RegisterUserScreen.routeName);
                    },
                  ),
                ],
              ),
            ),





                  // InkWell(
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Text("New User? Signup"),
                  //   ),
                  //   onTap: () {
                  //     Get.toNamed(RegisterUserScreen.routeName);
                  //   },
                  // ),
          ))



    ));}
}
