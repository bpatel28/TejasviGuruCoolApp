import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/screens/login_screen.dart';
import 'package:tejasvi_gurucool/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(top: 15.0, left: 10.0),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Text(
          "Home",
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
        ));
  }

  Widget _createDrawerItem(BuildContext context,
      {IconData icon, String text, GestureTapCallback onTap}) {
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
                icon: Icons.subject, text: "Subjects", onTap: () => _onSubjectsTap(context)),
            _createDrawerItem(context,
                icon: Icons.announcement, text: "Announcements", onTap: () => _onAnnouncementsTap(context)),
            _createDrawerItem(context,
                icon: Icons.people, text: "My Profile", onTap: () => _onMyProfileTap(context)),
            _createDrawerItem(context,
                icon: Icons.info, text: "About Us", onTap: () => _onAboutUsTap(context))
          ],
        ),
      ),
    );
  }
}
