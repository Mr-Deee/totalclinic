import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../Controller/auth_controller.dart';

class RegisterUserScreen extends StatelessWidget {
  static const String routeName = "/register_user";
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Signup"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: "FirstName",
                  isShowBorder: true,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.text,
                  controller: fname, prefixIcon:  Icon(
                  Icons.account_box,
                  color:  const Color(0xFFF01410),
                ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "LastName",
                  isShowBorder: true,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.text,
                  controller: fname, prefixIcon:  Icon(
                  Icons.account_box,
                  color:  const Color(0xFFF01410),
                ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "Email",
                  isShowBorder: true,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                  controller: email,
                  isEmail:true,
                  prefixIcon:  Icon(
                  Icons.email,
                  color:  const Color(0xFFF01410),
                ),

                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "Phone",
                  isShowBorder: true,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.phone,
                  controller: phone, prefixIcon:  Icon(
                  Icons.phone,
                  color:  const Color(0xFFF01410),
                ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "Password",
                  isShowBorder: true,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.text,
                  isPassword: true,
                  controller: password, prefixIcon:  Icon(
                  Icons.lock_outline,
                  color:  const Color(0xFFF01410),
                ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<AuthController>(builder: (context) {
                  return authController.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                            btnTxt: "Signup",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              authController.startLoading();

                              await authController.registerUser(fname.text,lname.text,
                                  email.text, phone.text, password.text);

                              authController.stopLoading();
                            }
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
