import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalclinic/Pages/OfficeLocations.dart';
import 'package:totalclinic/Pages/SignUpPage.dart';
import 'package:totalclinic/services/database.dart';
import 'package:totalclinic/Pages/signin.dart';
import 'package:totalclinic/Pages/Dentist.dart';
import 'package:totalclinic/theme.dart';
import 'package:get/get.dart';
import 'Authentication/Binding/auth_binding.dart';
import 'Authentication/Views/Doctorlogin_screen.dart';
import 'Pages/bookingScreen.dart';
import 'Pages/home.dart';
import 'Pages/myAppointment.dart';
import 'Routes/app_pages.dart';
import 'models/user_model.dart';
import 'models/userfeild.dart';

/// App Root
///

// Define a key for storing the user's credentials
const String kCredentialsKey = 'credentials';

// Define a key for storing the user's role
const String kRoleKey = 'role';

// Define the roles for the app
enum UserRole {
  client,
  doctor,
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(),
    ),
    ChangeNotifierProvider<DoctorUser>(
      create: (context) => DoctorUser(),
    ),
  ], child: MyApp()));
}

DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference Doctor = FirebaseDatabase.instance.ref().child("Doctors");

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? userIsLoggedIn;
  final AuthService _authService = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;




  Future<UserRole?> getUserRole() async {
    String? role = await _firebaseAuth.currentUser?.uid;
    if ("Clients" == clients) {
      print("fff"+ role!);
      return UserRole.client;

    } else if (role == 'doctor') {
      return UserRole.doctor;
    } else {
      return null;
    }
  }
  @override
  void initState() {


    getUserRole();
    //getclienutreference()
    getLoggedInState();
    UserModel.getCurrentOnlineUserInfo(context);
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

// getclientreference() async{
//   User user;
//   DatabaseReference userRef;
//   user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     userRef =
//         FirebaseDatabase.instance.reference().child('Clients').child(user.uid);
//   }
// }

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
    return GetMaterialApp(
      color: Colors.white,
      title: "Total Clinic",
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),

      theme: ThemeData(
        primarySwatch: customPrimary,
        primaryColorLight: customPrimary[300],
        primaryColor: customPrimary[500],
        primaryColorDark: customPrimary[900],
      ),
        home: HomeScreen(),
      //conditionaal login

      // FutureBuilder<bool>(
      //   future: _authService.isLoggedIn(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.data == true) {
      //       // User is already logged in, navigate to the appropriate screen
      //       return FutureBuilder<UserRole?>(
      //         future: _authService.getUserRole(),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return CircularProgressIndicator();
      //           } else if (snapshot.data == UserRole.client) {
      //             return HomeScreen();
      //           } else if (snapshot.data == UserRole.doctor) {
      //             return DoctorLoginScreen();
      //           } else {
      //             return SignInPage();
      //           }
      //         },
      //       );
      //     } else {
      //       // User is not logged in, navigate to the login screen
      //       return SignInPage();
      //     }
      //   },
      // ),

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

class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Check if the user is already logged in
  Future<bool> isLoggedIn() async {
    String? credentials = await _storage.read(key: kCredentialsKey);
    return credentials != null;
  }

  // Get the user's role
  Future<UserRole?> getUserRole() async {
    String? role = await _storage.read(key: kRoleKey);
    if (role == 'client') {
      return UserRole.client;
    } else if (role == 'doctor') {
      return UserRole.doctor;
    } else {
      return null;
    }
  }

  // Log the user in
  Future<void> login(String username, String password, UserRole role) async {
    // Send the login request to the server and get the user's credentials
    String credentials = '...';

    // Store the credentials and role securely on the device
    await _storage.write(key: kCredentialsKey, value: credentials);
    await _storage.write(key: kRoleKey, value: role.toString());
  }

  // Log the user out
  Future<void> logout() async {
    await _storage.delete(key: kCredentialsKey);
    await _storage.delete(key: kRoleKey);
  }
}
