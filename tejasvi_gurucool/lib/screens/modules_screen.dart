import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class ModulesScreenArgs {
  final User user;
  final Subject subject;

  ModulesScreenArgs(this.user, this.subject);
}

class ModulesScreen extends StatelessWidget {
  Widget _getStudyModuleCard(BuildContext context, StudyModule module) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(module.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    CircularBox(
                      module.items.length.toString(),
                      padding: EdgeInsets.all(10.0),
                      color: const Color(0xFFffa500),
                    ),
                  ],
                ),
                Text(module.shortDescription),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ModulesScreenArgs args = ModalRoute.of(context).settings.arguments;
    final subject = args.subject;
    return Scaffold(
      appBar: AppBar(
        title: Text(subject != null ? subject.name : ""),
      ),
      body: Center(
        child: subject != null
            ? new ListView.builder(
                itemCount: subject.modules.length,
                itemBuilder: (context, index) =>
                    _getStudyModuleCard(context, subject.modules[index]),
              )
            : Text("No modules available."),
      ),
      drawer: AppDrawer(args.user, Routes.SUBJECTS),
    );
  }
}
