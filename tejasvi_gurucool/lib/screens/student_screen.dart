import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/students/students_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class StudentSceen extends StatelessWidget {
  String _getBatchesNames(
      final List<Batch> batches, final List<String> batchIds) {
    String name = "";
    for (int i = 0; i < batchIds.length; ++i) {
      for (int j = 0; j < batches.length; ++j) {
        if (batches[j].id == batchIds[i]) {
          name += batches[j].name + ",";
        }
      }
    }
    if (name.endsWith(",")) name = name.substring(0, name.length - 1);
    return name;
  }

  Widget _createStudentList(
      BuildContext context, final List<User> users, final List<Batch> batches) {
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
                      "Birth Date : ${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}"),
                  SizedBox(height: 2.0),
                  Text("Batches : ${_getBatchesNames(batches, user.batches)}")
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
                    child: Text(user.isAdmin
                        ? "Admin"
                        : user.isMember ? "Member" : "Free User"),
                    onPressed: () {
                      if (!user.isAdmin) {
                        context
                            .bloc<StudentsBloc>()
                            .add(ChangeMemberStatus(user.id, !user.isMember));
                      }
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
      body: BlocBuilder<BatchBloc, BatchState>(
        builder: (BuildContext batchBlocContext, BatchState batchState) {
          if (batchState is AllBatchLoaded) {
            return BlocBuilder<StudentsBloc, StudentsState>(
              bloc: context.bloc<StudentsBloc>(),
              builder: (BuildContext studentBlocContext,
                  StudentsState studentsState) {
                if (studentsState is StudentsInitial) {
                  Future.delayed(Duration.zero, () {
                    context.bloc<StudentsBloc>().add(GetAllStudents());
                  });
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (studentsState is StudentsFetchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (studentsState is StudentsFetchComplete) {
                  return Center(
                    child: _createStudentList(
                        context, studentsState.users, batchState.batches),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            Future.delayed(Duration.zero, () {
              context.bloc<BatchBloc>().add(FetchBatches());
            });
            return SizedBox.shrink();
          }
        },
      ),
      drawer: AppDrawer(Routes.STUDENTS),
    );
  }
}
