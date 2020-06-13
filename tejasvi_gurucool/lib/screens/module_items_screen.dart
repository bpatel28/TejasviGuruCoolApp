import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/screens/add_module.dart';
import 'package:url_launcher/url_launcher.dart';

class ModuleItemsScreenArgs {
  final Subject subject;

  ModuleItemsScreenArgs(this.subject);
}

class ModuleItemsScreen extends StatelessWidget {
  Widget getHeader(BuildContext context, Subject subject) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            subject.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Icon getIcon(ModuleItem item, double size) {
    if (item != null && item.isImage())
      return Icon(Icons.image, size: size);
    else if (item != null && item.isVideo())
      return Icon(Icons.video_library, size: size);
    else if (item != null && item.isPDF())
      return Icon(Icons.assignment, size: size);
    else
      return Icon(Icons.description, size: size);
  }

  Future<void> onTapModuleItem(BuildContext context, ModuleItem item) async {
    if (item.isVideo()) {
      if (await canLaunch(item.filePath)) {
        await launch(item.filePath, enableJavaScript: true, forceWebView: true);
      }
    }
  }

  List<Widget> getItems(BuildContext context, final Subject subject) {
    List<Widget> items = <Widget>[];

    items.add(getHeader(context, subject));

    for (int i = 0; i < subject.modules.length; ++i) {
      final ModuleItem item = subject.modules[i];
      if (item != null) {
        items.add(
          Card(
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
                          item.name,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          item.description,
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final ModuleItemsScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.subject.name),
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (BuildContext context, UserState state) {
              if (state is AuthenticatedUser && state.user.isAdmin) {
                return IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushNamed(
                        context,
                        Routes.ADD_MODULE,
                        arguments: AddModuleScreenArgs(args.subject),
                      );
                    });
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: getItems(context, args.subject),
        ),
      ),
    );
  }
}
