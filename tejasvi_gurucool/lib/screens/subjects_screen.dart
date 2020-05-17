import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class SubjectsScreen extends StatelessWidget {
  final User _user;

  SubjectsScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
      ),
      body: Center(
        child: Text("Home Page"),
      ),
      drawer: AppDrawer(_user, Routes.SUBJECTS),
    );
  }
}