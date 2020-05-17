import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class MyProfile extends StatelessWidget {
  final User _user;

  MyProfile(this._user);

  Widget createUserInfoText(String label, String text) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          text.length > 0
              ? Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFAF0)
                  ),
                  child: SizedBox(
                    width: 500,
                    child: Text(text,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String formatPhoneNo(String phoneNo) {
    if (phoneNo.length == 10)
      return "(${phoneNo.substring(0, 3)}) ${phoneNo.substring(3, 6)} - ${phoneNo.substring(6, 10)}";
    else
      return phoneNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.people,
              size: 200,
            ),
            createUserInfoText(_user.getFullName(), ""),
            createUserInfoText("Batch:", _user.batch.name),
            createUserInfoText("Birth Date: ", formatDate(_user.birthDate)),
            createUserInfoText(
                "Phone No: ", formatPhoneNo(_user.phoneNo.toString())),
            createUserInfoText("Username: ", _user.username),
            createUserInfoText("Email: ", _user.email),
            createUserInfoText("Created On: ", formatDate(_user.createdOn)),
            createUserInfoText("Updated On: ", formatDate(_user.updatedOn)),
          ],
        ),
      ),
      drawer: AppDrawer(_user, Routes.MY_PROFILE),
    );
  }
}
