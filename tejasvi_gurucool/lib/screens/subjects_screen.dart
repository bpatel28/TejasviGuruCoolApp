import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/screens/modules_screen.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class SubjectsScreen extends StatelessWidget {
  final User _user;

  SubjectsScreen(this._user);

  List<Subject> _getSubjects() {
    List<Subject> subjects = <Subject>[];
    _user.batches.forEach((batch) {
      subjects.addAll(batch.subjects);
    });
    return subjects;
  }

  void onSubjectCardTap(BuildContext context, Subject subject) {
    if (subject != null) {
      Navigator.pushNamed(context, Routes.MODULES,
          arguments: ModulesScreenArgs(_user, subject));
    }
  }

  Widget _getSubjectCard(BuildContext context, Subject subject) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () => onSubjectCardTap(context, subject),
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
    final subjects = _getSubjects();
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
      ),
      body: Center(
        child: new ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) =>
              _getSubjectCard(context, subjects[index]),
        ),
      ),
      drawer: AppDrawer(_user, Routes.SUBJECTS),
    );
  }
}
