import 'package:flutter/cupertino.dart';
import 'package:totalclinic/services/authentication.dart';

class SignInPage extends StatefulWidget {
  const SignInPage(void Function() toggleView, {Key key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailTextEditingController =
  new TextEditingController();
  TextEditingController passwordTextEditingController =
  new TextEditingController();
  AuthMethods authService = new AuthMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool incorrectLogin = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
