import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: ListView(
        children: <Widget>[
          Icon(Icons.school, size: 200),
          Text(
            "Tejasvi GuruCool",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Tejasvi gurucool is Gujarat's premier coaching centre which continuously innovates to help students actualize their dreams through integrated efforts of an interactive learning system.",
              style: TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
      drawer: AppDrawer(Routes.ABOUT_US),
    );
  }
}
