import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/subject/subject_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/screens/module_items_screen.dart';
import 'package:tejasvi_gurucool/widgets/app_drawer.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class SubjectsScreen extends StatelessWidget {
  void onSubjectCardTap(BuildContext context, subject) {
    if (subject != null) {
      Future.delayed(
          Duration.zero,
          () => Navigator.pushNamed(context, Routes.MODULE_ITEMS,
              arguments: ModuleItemsScreenArgs(subject)));
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (BuildContext context, UserState state) {
              if (state is AuthenticatedUser) {
                return IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
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
      drawer: AppDrawer(Routes.SUBJECTS),
    );
  }

  Widget _buildSubjectsList(BuildContext context, User user) {
    return BlocBuilder<SubjectBloc, SubjectState>(
      builder: (BuildContext context, SubjectState state) {
        if (state is SubjectsLoaded) {
          return ListView.builder(
            itemCount: state.subjects.length,
            itemBuilder: (context, index) =>
                _getSubjectCard(context, state.subjects[index]),
          );
        } else if (state is LoadingSubjects) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          Future.delayed(
              Duration.zero,
              () =>
                  context.bloc<SubjectBloc>().add(FetchSubjects(user.batches)));
          return Container();
        }
      },
    );
  }
}
