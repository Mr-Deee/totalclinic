import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:totalclinic/Pages/SignUpPage.dart';
import 'package:totalclinic/services/authenticate.dart';
import 'package:totalclinic/services/database.dart';
import 'package:totalclinic/Pages/signin.dart';
import 'package:totalclinic/theme.dart';
import 'package:totalclinic/users.dart';

import 'Pages/home.dart';
import 'models/user_model.dart';
/// App Root
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(),
    ),
    //




  ],

      child: MyApp()  )

    );
}
DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference Doctor = FirebaseDatabase.instance.ref().child("Doctors");


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getclientreference();
_getUserDetails(context);
    getLoggedInState();
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment =
    false; //<--
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1f1e30),
        systemNavigationBarColor: Color(0xFF1f1e30),
      ),
    );
  }
getclientreference() async{
  User user;
  DatabaseReference userRef;
  user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    userRef =
        FirebaseDatabase.instance.reference().child('Clients').child(user.uid);
  }
}

  _getUserDetails(BuildContext context) async {

    DatabaseReference clients= FirebaseDatabase.instance.ref().child("Clients");
    DatabaseEvent event = await clients.once();

    context.read<UserModel>().setUser(UserModel.fromMap(Map<String, dynamic>.from(event.snapshot.value)));

    // setState(() {});
  }


  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      color: Colors.white,
      title: "Flutter Medical",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),



      theme: ThemeData(
        primarySwatch: customPrimary,
        primaryColorLight: customPrimary[300],
        primaryColor: customPrimary[500],
        primaryColorDark: customPrimary[900],
      ),
       // initialRoute: SignInPage.idScreen,
    initialRoute: FirebaseAuth.instance.currentUser == null
    ? SignInPage.idScreen
        : HomeScreen.idScreen,
    routes: {
      SignUpPage.idScreen: (context) => SignUpPage(),
      SignInPage.idScreen: (context) => SignInPage(),
      HomeScreen.idScreen:(context)=>HomeScreen(),


    }
    );
  }
}
