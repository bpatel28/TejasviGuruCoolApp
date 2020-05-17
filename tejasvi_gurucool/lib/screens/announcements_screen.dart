import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class Announcement extends StatelessWidget {
  final User _user;

  Announcement(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement"),
      ),
      body: Center(
        child: Text("Announcement Page"),
      ),
      drawer: AppDrawer(_user, Routes.ANNOUNCEMENTS),
    );
  }
}