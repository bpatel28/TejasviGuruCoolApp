import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class AboutUs extends StatelessWidget {
  final User _user;

  AboutUs(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Center(
        child: Text("About Page"),
      ),
      drawer: AppDrawer(_user, Routes.ABOUT_US),
    );
  }
}