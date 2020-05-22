import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/file_model.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';

class ModuleItemsScreenArgs {
  final User user;
  final StudyModule studyModule;

  ModuleItemsScreenArgs(this.user, this.studyModule);
}

Widget getHeader(BuildContext context, StudyModule module) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          module.longDescription,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Icon getIcon(ModuleItem item, double size) {
  final ModuleFile file = item.file;
  if (file != null && file.isImage())
    return Icon(Icons.image, size: size);
  else if (file != null && file.isVideo())
    return Icon(Icons.video_library, size: size);
  else if (file != null && file.isPDF())
    return Icon(Icons.assignment, size: size);
  else
    return Icon(Icons.description, size: size);
}

void onTapModuleItem(BuildContext context, ModuleItem item) {
  if (item.file.isVideo()) {
    Navigator.pushNamed(context, Routes.VIDEO_SCREEN);
  }
}

List<Widget> getItems(BuildContext context, StudyModule module) {
  List<Widget> items = <Widget>[];

  items.add(getHeader(context, module));

  for (int i = 0; i < module.items.length; ++i) {
    final ModuleItem item = module.items[i];
    if (item != null) {
      items.add(Card(
        child: InkWell(
            onTap: () => onTapModuleItem(context, item),
            splashColor: Theme.of(context).accentColor,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  getIcon(item, 30.0),
                  SizedBox(
                    width: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(item.description, style: TextStyle(fontSize: 10.0)),
                    ],
                  )
                ],
              ),
            )),
      ));
    }
  }

  return items;
}

class ModuleItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ModuleItemsScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.studyModule.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: getItems(context, args.studyModule),
        ),
      ),
      drawer: AppDrawer(args.user, Routes.SUBJECTS),
    );
  }
}