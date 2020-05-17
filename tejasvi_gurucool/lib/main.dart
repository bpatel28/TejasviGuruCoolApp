import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/screens/about_us_screen.dart';
import 'package:tejasvi_gurucool/screens/announcements_screen.dart';
import 'package:tejasvi_gurucool/screens/modules_screen.dart';
import 'package:tejasvi_gurucool/screens/my_profile_screen.dart';
import 'package:tejasvi_gurucool/screens/subjects_screen.dart';
import 'package:tejasvi_gurucool/screens/login_screen.dart';
import 'package:tejasvi_gurucool/screens/register_screen.dart';
import 'mock_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = Mock.user;
    return MaterialApp(
      title: 'Tejasvi GuruCool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.LOGIN,
      routes: {
        Routes.LOGIN: (context) => LoginScreen(),
        Routes.REGISTER: (context) => RegisterScreen(),
        Routes.MODULES: (context) => ModulesScreen(),
        Routes.ANNOUNCEMENTS: (context) => AnnouncementScreen(user),
        Routes.MY_PROFILE: (context) => MyProfile(user),
        Routes.ABOUT_US: (context) => AboutUs(user),
      },
      home: SubjectsScreen(user),
    );
  }
}
