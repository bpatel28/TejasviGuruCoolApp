import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to exit?'),
          actions: [
            FlatButton(
              child: Text('Yes'),
              onPressed: () => SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.person,
              size: 200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: LoginForm(),
            )
          ],
        ),
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

  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateEmail(String username) {
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

  void _onLoginButtonPressed(BuildContext context, UserBloc bloc) {
    if (!_formKey.currentState.validate()) return;
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      bloc.add(LoginUser(email: email, password: password));
    } on Exception catch (e) {
      print(e);
      showSnackBar(context, "Login Failed. Please try again");
    }
  }

  void _onSignUpButtonPressed(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, Routes.REGISTER);
    });
  }

  void _onResetPasswordClicked(BuildContext context, UserBloc bloc) {
    final email = _emailController.text.trim();
    if (email == null || email == "" || !email.contains(".com") || !email.contains("@")) {
      showSnackBar(context, "Please enter valid email.");
      return;
    }
    bloc.add(ResetPassword(email));
    showSnackBar(context, "Sending Reset Password link");
    Future.delayed(Duration(seconds: 2), () {
      showSnackBar(
        context, "Reset Password email sent. Please check your email.");
    });
  }

  @override
  build(BuildContext context) {
    return Container(
      child: BlocBuilder<UserBloc, UserState>(
        bloc: context.bloc(),
        builder: (BuildContext context, UserState state) {
          if (state is AuthenticatedUser) {
            return _buildLoginComplete(context, state.user);
          } else if (state is LoginLoading) {
            return _buildLoading(context);
          } else if (state is LoginFailed) {
            Future.delayed(Duration.zero, () {
              showSnackBar(context, state.message);
            });
            return _buildLoginForm(context);
          } else {
            return _buildLoginForm(context);
          }
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            decoration: InputDecoration(
              labelText: "Enter Email",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Forgot password? reset now.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                splashColor: Theme.of(context).accentColor,
                onTap: () => _onResetPasswordClicked(context, context.bloc<UserBloc>()),
              )
            ],
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            splashColor: Theme.of(context).accentColor,
            child: Text("LOGIN"),
            onPressed: () => _onLoginButtonPressed(context, context.bloc()),
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

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoginComplete(BuildContext context, User user) {
    if (user.isAdmin || user.isMember) {
      Future.delayed(
          Duration.zero, () => Navigator.pushNamed(context, Routes.SUBJECTS));
    }
    return Column(
      children: [
        Text(
          "Login Successful.",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Please wait until you are registered by Tejasvi GuruCool.",
          style: TextStyle(fontSize: 15.0),
        ),
        SizedBox(
          height: 7.0,
        ),
        Text(
          "Call or Text at +91 9427656100 to register yourself.",
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }
}
