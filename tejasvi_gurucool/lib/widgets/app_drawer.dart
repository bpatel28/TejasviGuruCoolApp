import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

class AppDrawer extends StatelessWidget {
  final User _user;
  final String _selectedRoute;

  AppDrawer(this._user, this._selectedRoute);

  Widget _createHeader(BuildContext context) {
    List<Widget> headerWidgets = <Widget>[];
    headerWidgets.add(
      Text(
        _user.getName(),
        style: TextStyle(
            color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w500),
      ),
    );
    for (int i = 0; i < _user.batches.length; ++i) {
      headerWidgets.add(Text(
        _user.batches[i].name,
        style: TextStyle(
          color: Colors.white
        ),
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
              _user.getInitials(),
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
        _createHeader(context),
        _createDrawerItem(context,
            icon: Icons.subject,
            text: "Subjects",
            onTap: () => _changeRoute(context, Routes.SUBJECTS),
            selected: _selectedRoute == Routes.SUBJECTS),
        _createDrawerItem(context,
            icon: Icons.announcement,
            text: "Announcements",
            onTap: () => _changeRoute(context, Routes.ANNOUNCEMENTS),
            selected: _selectedRoute == Routes.ANNOUNCEMENTS),
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
    ));
  }
}
