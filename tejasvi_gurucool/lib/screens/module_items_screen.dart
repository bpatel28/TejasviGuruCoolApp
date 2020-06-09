import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/module/module_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/file_model.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';
import 'package:tejasvi_gurucool/repository/module_repository.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ModuleItemsScreenArgs {
  final StudyModule studyModule;

  ModuleItemsScreenArgs(this.studyModule);
}

class ModuleItemsScreen extends StatelessWidget {
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

  Future<void> onTapModuleItem(BuildContext context, ModuleItem item) async {
    if (item.file.isVideo()) {
      if (await canLaunch(item.file.path)) {
        await launch(item.file.path,
            enableJavaScript: true, forceWebView: true);
      }
    }
  }

  List<Widget> getItems(BuildContext context, final StudyModule module,
      final List<ModuleItem> moduleItems) {
    List<Widget> items = <Widget>[];

    items.add(getHeader(context, module));

    for (int i = 0; i < moduleItems.length; ++i) {
      final ModuleItem item = moduleItems[i];
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
                        Text(item.description,
                            style: TextStyle(fontSize: 10.0)),
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

  @override
  Widget build(BuildContext context) {
    final ModuleItemsScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.studyModule.title),
      ),
      body: BlocProvider(
        create: (BuildContext context) => ModuleBloc(ModuleRepository()),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: BlocBuilder<ModuleBloc, ModuleState>(
            builder: (context, state) {
              if (state is ItemsLoaded) {
                return ListView(
                  children: getItems(context, args.studyModule, state.items),
                );
              } else if (state is LoadingItems) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                context
                    .bloc<ModuleBloc>()
                    .add(FetchModuleItemsEvent(args.studyModule.id));
                return Container();
              }
            },
          ),
        ),
      ),
      drawer: BlocBuilder<UserBloc, UserState>(
        bloc: context.bloc(),
        builder: (BuildContext context, UserState state) {
          if (state is AuthenticatedUser) {
            return AppDrawer(Routes.SUBJECTS, state.user, state.batches);
          } else {
            return Text("Something went wrong.");
          }
        },
      ),
    );
  }
}
