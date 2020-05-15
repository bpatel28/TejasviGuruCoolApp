import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.people,
            size: 200,
          ),
          LoginForm()
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);

  Widget getTextFiled(hintText, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: textStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  @override
  build(BuildContext context) {
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: getTextFiled("Email"),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: getTextFiled("Password", obscureText: true),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: loginButton,
        ),
      ],
    );
  }
}
