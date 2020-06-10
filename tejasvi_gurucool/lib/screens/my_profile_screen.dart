import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class MyProfileScreen extends StatelessWidget {
  final Color _cardBackgroundColor = const Color(0xFFfbf7f9);

  Widget createUserInfoText(String label, String text) {
    return Card(
      color: _cardBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(10),
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
                    decoration: BoxDecoration(color: const Color(0xFFFAF0)),
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
      ),
    );
  }

  Widget getUserBatchesWidget(User user, List<Batch> batches) {
    if (user.batches.length == 0 || (batches != null && batches.length == 0)) return Container();

    List<Batch> userBatches = <Batch>[];

    user.batches.forEach((userBatchItemId) {
      batches.forEach((batchItem) {
        if (batchItem.id == userBatchItemId) {
          userBatches.add(batchItem);
        }
      });
    });

    List<Widget> userBatchWidgets = <Widget>[];

    userBatchWidgets.add(
      Text(
        "Batches:",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    for (int i = 0; i < userBatches.length; ++i) {
      userBatchWidgets.add(Container(
        decoration: BoxDecoration(color: const Color(0xFFFAF0)),
        child: SizedBox(
          width: 500,
          child: Text(userBatches[i].name,
              style: TextStyle(
                fontSize: 18,
              )),
        ),
      ));
    }

    return Card(
      color: _cardBackgroundColor,
      child: Container(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: userBatchWidgets,
          )),
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
      body: BlocBuilder<UserBloc, UserState>(
        bloc: context.bloc(),
        builder: (BuildContext context, UserState state) {
          if (state is AuthenticatedUser) {
            return _buildMyProfileInfo(context, state.user, state.batches);
          } else {
            return Text("Something went wrong.");
          }
        },
      ),
      drawer: BlocBuilder<UserBloc, UserState>(
        bloc: context.bloc(),
        builder: (BuildContext context, UserState state) {
          if (state is AuthenticatedUser) {
            return AppDrawer(Routes.MY_PROFILE, state.user, state.batches);
          } else {
            return Text("Something went wrong.");
          }
        },
      ),
    );
  }

  Widget _buildMyProfileInfo(BuildContext context, User user, List<Batch> batches) {
    return Center(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          CircularBox(
            user.getInitials(),
            color: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            fontSize: 25.0,
          ),
          createUserInfoText(user.getFullName(), ""),
          getUserBatchesWidget(user, batches),
          createUserInfoText("Birth Date: ", formatDate(user.birthDate)),
          createUserInfoText(
              "Phone No: ", formatPhoneNo(user.phoneNo.toString())),
          createUserInfoText("Email: ", user.email),
          createUserInfoText("Created On: ", formatDate(user.createdOn)),
          createUserInfoText("Updated On: ", formatDate(user.updatedOn)),
        ],
      ),
    );
  }
}
