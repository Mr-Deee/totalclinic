import 'package:get/get.dart';

import '../Authentication/Binding/auth_binding.dart';
import '../Authentication/Views/Doctorlogin_screen.dart';
import '../Authentication/Views/register_user_screen.dart';
import '../Authentication/Views/student_login.dart';
import '../Pages/home.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: DoctorLoginScreen.routeName,
      page: () => DoctorLoginScreen(),
      binding: AuthBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: RegisterUserScreen.routeName,
      page: () => RegisterUserScreen(),
      binding: AuthBinding(),
      preventDuplicates: true,
    ),
    // GetPage(
    //   name: HomeScreen.idScreen,
    //   page: () =>HomeScreen(),
    //   binding: AuthBinding(),
    //   preventDuplicates: true,
    // ),
    // GetPage(
    //   name: ClassScreen.routeName,
    //   page: () => ClassScreen(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
    // GetPage(
    //   name: StudentsScreen.routeName,
    //   page: () => StudentsScreen(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
    // GetPage(
    //   name: AddStudentScreen.routeName,
    //   page: () => AddStudentScreen(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
    // GetPage(
    //   name: AttendanceScreen.routeName,
    //   page: () => AttendanceScreen(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
    // GetPage(
    //   name: ViewAttendanceByStd.routeName,
    //   page: () => ViewAttendanceByStd(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
    // GetPage(
    //   name: TeacherProfileScreen.routeName,
    //   page: () => TeacherProfileScreen(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    //),
    // GetPage(
    //   name: ProfileStatus.routeName,
    //   page: () => const ProfileStatus(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
    GetPage(
      name: StudentLogin.routeName,
      page: () => StudentLogin(),
      binding: AuthBinding(),
      preventDuplicates: true,
    ),
    // GetPage(
    //   name: ViewStudentClasses.routeName,
    //   page: () => ViewStudentClasses(),
    //   binding: DashboardBinding(),
    //   preventDuplicates: true,
    // ),
  ];
}
