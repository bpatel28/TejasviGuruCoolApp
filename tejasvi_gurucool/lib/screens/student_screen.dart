import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class StudentSceen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Registration"),
      ),
      body: Center(
        child: Text("Students List"),
      ),
      drawer: AppDrawer(Routes.STUDENTS),
    );
  }
}
