import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/students/students_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class StudentSceen extends StatelessWidget {
  Widget _createStudentList(BuildContext context, List<User> users) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        final user = users[i];
        return Card(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.getFullName(),
                  ),
                  SizedBox(height: 2.0),
                  Text(user.email),
                  SizedBox(height: 2.0),
                  Text(user.phoneNo),
                  SizedBox(height: 2.0),
                  Text(
                      "Birth Date : ${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  RaisedButton(
                    color: user.isMember ? Colors.green : Colors.red,
                    textColor: Colors.white,
                    splashColor: Theme.of(context).accentColor,
                    child: Text(user.isMember ? 'Member' : 'Free User'),
                    onPressed: () {
                      context.bloc<StudentsBloc>().add(ChangeMemberStatus(user.id, !user.isMember));
                    },
                  )
                ],
              ),
            )
          ],
        ));
      },
      itemCount: users?.length ?? 0,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Registration"),
      ),
      body: BlocBuilder<StudentsBloc, StudentsState>(
        bloc: context.bloc<StudentsBloc>(),
        builder: (BuildContext context, StudentsState state) {
          if (state is StudentsInitial) {
            Future.delayed(Duration.zero, () {
              context.bloc<StudentsBloc>().add(GetAllStudents());
            });
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentsFetchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentsFetchComplete) {
            return Center(
              child: _createStudentList(context, state.users),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: AppDrawer(Routes.STUDENTS),
    );
  }
}
