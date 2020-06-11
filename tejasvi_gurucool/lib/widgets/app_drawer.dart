import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class AppDrawer extends StatelessWidget {
  final String _selectedRoute;

  AppDrawer(this._selectedRoute);

  List<Batch> filterUserBatches(final User user, final List<Batch> batches) {
    if (user.batches.length == 0 || (batches != null && batches.length == 0))
      return <Batch>[];

    List<Batch> userBatches = <Batch>[];

    user.batches.forEach((batchId) {
      batches.forEach((batchItem) {
        if (batchItem.id == batchId) {
          userBatches.add(batchItem);
        }
      });
    });

    return userBatches;
  }

  Widget _createHeader(
      BuildContext context, final User user, final List<Batch> batches) {
    List<Widget> headerWidgets = <Widget>[];
    headerWidgets.add(
      Text(
        user.getName(),
        style: TextStyle(
            color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w500),
      ),
    );
    final userBatches = filterUserBatches(user, batches);
    for (int i = 0; i < userBatches.length; ++i) {
      headerWidgets.add(Text(
        userBatches[i].name,
        style: TextStyle(color: Colors.white),
      ));
    }
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(top: 15.0, left: 10.0),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircularBox(
              user.getInitials(),
              padding: EdgeInsets.all(12.0),
              color: Colors.red,
              textColor: Colors.white,
              fontSize: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: headerWidgets,
              ),
            )
          ],
        ));
  }

  Widget _createDrawerItem(BuildContext context,
      {IconData icon,
      String text,
      GestureTapCallback onTap,
      bool selected: false}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      selected: selected,
      onTap: onTap,
    );
  }

  void _changeRoute(BuildContext context, String routeName) {
    if (routeName == Routes.SUBJECTS) {
      // subject route is home route.
      // pop until home route comes back.
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (routeName != _selectedRoute) {
      // pop until home route comes back and push new route.
      Navigator.pushNamedAndRemoveUntil(
          context, routeName, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // _createHeader(context),
          BlocBuilder<UserBloc, UserState>(
            bloc: context.bloc<UserBloc>(),
            builder: (BuildContext userBlocContext, UserState userState) {
              if (userState is AuthenticatedUser) {
                return BlocBuilder(
                  bloc: context.bloc<BatchBloc>(),
                  builder:
                      (BuildContext batchBlocContext, BatchState batchState) {
                    if (batchState is BatchInitial) {
                      Future.delayed(Duration.zero, () {
                        context.bloc<BatchBloc>().add(FetchBatches());
                      });
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (batchState is AllBatchLoaded) {
                      return _createHeader(
                          context, userState.user, batchState.batches);
                    } else {
                      return Text("");
                    }
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          _createDrawerItem(context,
              icon: Icons.subject,
              text: "Subjects",
              onTap: () => _changeRoute(context, Routes.SUBJECTS),
              selected: _selectedRoute == Routes.SUBJECTS),
          _createDrawerItem(context,
              icon: Icons.people,
              text: "My Profile",
              onTap: () => _changeRoute(context, Routes.MY_PROFILE),
              selected: _selectedRoute == Routes.MY_PROFILE),
          _createDrawerItem(context,
              icon: Icons.info,
              text: "About Us",
              onTap: () => _changeRoute(context, Routes.ABOUT_US),
              selected: _selectedRoute == Routes.ABOUT_US)
        ],
      ),
    );
  }
}
