import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/screens/login_screen.dart';
import 'package:tejasvi_gurucool/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tejasvi GuruCool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login' : (context) => LoginScreen(),
        '/register' : (context) => RegisterScreen(),
      },
    );
  }
}