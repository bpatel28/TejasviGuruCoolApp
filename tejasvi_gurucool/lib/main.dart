import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/screens/login_screen.dart';
import 'package:tejasvi_gurucool/screens/register_screen.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final User user = new User(
      id: -1,
      firstName: "Brijesh",
      lastName: "Patel",
      middleName: "Jayendrabhai",
      birthDate: new DateTime(1995, 5, 28),
      phoneNo: 5877001874,
      email: "b.patel9528@gmail.com",
      password: "1234567",
      createdOn: DateTime.now().subtract(new Duration(days: 5)),
      updatedOn: DateTime.now(),
    );
    return MaterialApp(
      title: 'Tejasvi GuruCool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
      home: MyHomePage(UniqueKey(), user),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final User _user;

  MyHomePage(Key key, this._user) : super(key: key);

  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(top: 15.0, left: 10.0),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _user.getName(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Batch 10A",
              style: TextStyle(
                color: Colors.black,
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

  void _onSubjectsTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onAnnouncementsTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onMyProfileTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onAboutUsTap(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Home Page"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(context),
            _createDrawerItem(context,
                icon: Icons.subject,
                text: "Subjects",
                onTap: () => _onSubjectsTap(context),
                selected: true),
            _createDrawerItem(context,
                icon: Icons.announcement,
                text: "Announcements",
                onTap: () => _onAnnouncementsTap(context)),
            _createDrawerItem(context,
                icon: Icons.people,
                text: "My Profile",
                onTap: () => _onMyProfileTap(context)),
            _createDrawerItem(context,
                icon: Icons.info,
                text: "About Us",
                onTap: () => _onAboutUsTap(context))
          ],
        ),
      ),
    );
  }
}
