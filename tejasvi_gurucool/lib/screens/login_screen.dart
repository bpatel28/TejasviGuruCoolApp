import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: LoginForm(),
          )
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
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _passwordVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return "Username is empty";
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return "Password is empty";
    }
    return null;
  }

  void showSnackBar(BuildContext context, message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _onLoginButtonPressed(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    try {
      final String email = _usernameController.text;
      final String password = _passwordController.text;

      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        showSnackBar(context, "Login Successful");
        Navigator.of(context).pushNamed(Routes.SUBJECTS);
      } else {
        throw new Exception("Invalid credentials.");
      }
    } on Exception catch (e) {
      print(e);
      showSnackBar(context, "Login Failed. Please try again");
    }
  }

  void _onSignUpButtonPressed(context) {
    Navigator.of(context).pushNamed(Routes.REGISTER);
  }

  @override
  build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            validator: _validateUsername,
            decoration: InputDecoration(
              labelText: "Enter Username",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: _togglePasswordVisibility,
              ),
              labelText: "Enter Password",
              border: OutlineInputBorder(),
            ),
            obscureText: !_passwordVisible,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            splashColor: Theme.of(context).accentColor,
            child: Text("LOGIN"),
            onPressed: () => _onLoginButtonPressed(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't have an account.",
                style: TextStyle(fontSize: 15),
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Register Now.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                splashColor: Theme.of(context).accentColor,
                onTap: () => _onSignUpButtonPressed(context),
              )
            ],
          ),
        ],
      ),
    );
  }
}
