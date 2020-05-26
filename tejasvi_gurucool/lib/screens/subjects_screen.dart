import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/screens/modules_screen.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectsScreen> {
  bool _subjectLoaded = false;

  void onSubjectCardTap(BuildContext context, User user, Subject subject) {
    if (subject != null) {
      Future.delayed(
          Duration.zero,
          () => Navigator.pushNamed(context, Routes.MODULES,
              arguments: ModulesScreenArgs(user, subject)));
    }
  }

  Widget _getSubjectCard(BuildContext context, User user, Subject subject) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () => onSubjectCardTap(context, user, subject),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(subject.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    CircularBox(
                      subject.modules.length.toString(),
                      padding: EdgeInsets.all(10.0),
                      color: const Color(0xFFffa500),
                    ),
                  ],
                ),
                Text(subject.description),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
      ),
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (BuildContext context, UserState state) {
            if (state is AuthenticatedUser) {
              return _buildSubjectsList(context, state.user);
            } else {
              return Text("Something went wrong.");
            }
          },
        ),
      ),
      drawer: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state is AuthenticatedUser) {
            return AppDrawer(Routes.SUBJECTS, state.user);
          } else {
            return Text("Something went wrong.");
          }
        },
      ),
    );
  }

  Widget _buildSubjectsList(BuildContext context, User user) {
    return BlocBuilder<BatchBloc, BatchState>(
      builder: (BuildContext context, BatchState state) {
        if (state is SubjectsLoaded) {
          return ListView.builder(
            itemCount: state.subjects.length,
            itemBuilder: (context, index) =>
                _getSubjectCard(context, user, state.subjects[index]),
          );
        } else {
          return _buildSubjectLoader(context, context.bloc(), user);
        }
      },
    );
  }

  Widget _buildSubjectLoader(BuildContext context, BatchBloc bloc, User user) {
    if (!_subjectLoaded) {
      Future.delayed(Duration.zero, () {
        this.setState(() {
          _subjectLoaded = true;
        });
        bloc.add(FetchSubjects(user.batches));
      });
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
