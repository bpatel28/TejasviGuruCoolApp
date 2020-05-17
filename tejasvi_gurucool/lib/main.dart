import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/screens/about_us.dart';
import 'package:tejasvi_gurucool/screens/subjects_screen.dart';
import 'package:tejasvi_gurucool/screens/login_screen.dart';
import 'package:tejasvi_gurucool/screens/register_screen.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final User user = new User(
      id: -1,
      firstName: "Brijesh",
      lastName: "Patel",
      middleName: "Jayendrabhai",
      birthDate: new DateTime(1995, 5, 28),
      phoneNo: 5877001874,
      email: "b.patel9528@gmail.com",
      password: "1234567",
      createdOn: DateTime.now().subtract(new Duration(days: 5)),
      updatedOn: DateTime.now(),
    );
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
        Routes.ABOUT_US: (context) => AboutUs(user)
      },
      home: SubjectsScreen(user),
    );
  }
}
