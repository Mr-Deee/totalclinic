import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:totalclinic/models/user_model.dart';

import '../../Pages/home.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../Controller/auth_controller.dart';
import 'Doctorlogin_screen.dart';


class StudentLogin extends StatelessWidget {
  static const String routeName = "/student_login";
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text("Student Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: SvgPicture.asset(
                          "assets/icons/chat.svg",
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      hintText: "Email",
                      isShowBorder: true,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      controller: email, prefixIcon:  Icon(
                      Icons.email,
                      color:  const Color(0xFFF01410),
                    ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "Roll No",
                    isShowBorder: true,
                    required: false,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    controller: password, prefixIcon:  Icon(
                    Icons.lock_outline,
                    color:  const Color(0xFFF01410),
                  ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      GetBuilder<AuthController>(builder: (_) {
                        return authController.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                btnTxt: "Login",
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    authController.startLoading();
                                    UserModel? student = await authController
                                        .getClient(email.text, password.text);
                                    authController.stopLoading();
                                    if (student != null) {
                                      authController.setStudent(student);
                                      Get.offAllNamed(
                                          HomeScreen.idScreen,
                                          arguments: student);
                                      Fluttertoast.showToast(
                                          msg: "Login Successfully");
                                    }
                                  }
                                },
                              );
                      }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                          minimumSize: Size(150, 50),
                        ),

                          onPressed: () {
                            Get.toNamed(DoctorLoginScreen.routeName);
                          },
                          child: const Text("Teacher Login"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
