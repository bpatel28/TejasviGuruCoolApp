import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class ModulesScreenArgs {
  final User user;
  final Subject subject;

  ModulesScreenArgs(this.user, this.subject);
}

class ModulesScreen extends StatelessWidget {
  Widget _getModuleItemsCountCircle(BuildContext context, StudyModule module) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amberAccent,
      ),
      child: Text(module.items.length.toString()),
    );
  }

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
                    _getModuleItemsCountCircle(context, module),
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
