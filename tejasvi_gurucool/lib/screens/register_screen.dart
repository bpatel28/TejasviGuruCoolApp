import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Icon(
            Icons.people,
            size: 200,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: RegisterForm(),
          )
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateFirstName(String value) {
    if (value.isEmpty) {
      return "First Name can not be empty.";
    }
    return null;
  }

  String _validateLastName(String value) {
    if (value.isEmpty) {
      return "Last Name can not be empty.";
    }
    return null;
  }

  String _validatePhoneNo(String value) {
    if (value.isEmpty) {
      return "Phone No can not be empty.";
    }
    return null;
  }

  String _validateUsername(String value) {
    if (value.isEmpty) {
      return "User name can not be empty.";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Password can not be empty.";
    }
    return null;
  }

  void showSnackBar(BuildContext context, message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _onSignUpButtonPressed(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    print(_formKey.currentState.validate());
    showSnackBar(context, "Sign Up Successful");
    Navigator.of(context).pushNamed("/");
  }

  void _onLoginButtonPressed(context) {
    Navigator.of(context).pop();
  }

  @override
  build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _firstNameController,
            validator: _validateFirstName,
            decoration: InputDecoration(
                labelText: "Enter First Name", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _lastNameController,
            validator: _validateLastName,
            decoration: InputDecoration(
                labelText: "Enter Last Name", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _middleNameController,
            decoration: InputDecoration(
                labelText: "Enter Middle Name", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _phoneNoController,
            validator: _validatePhoneNo,
            decoration: InputDecoration(
                labelText: "Enter Phone No", border: OutlineInputBorder()),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _usernameController,
            validator: _validateUsername,
            decoration: InputDecoration(
                labelText: "Enter Username", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                labelText: "Enter Email", border: OutlineInputBorder()),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                labelText: "Enter Password",
                border: OutlineInputBorder()),
            obscureText: !_passwordVisible,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            splashColor: Theme.of(context).accentColor,
            child: Text("SIGN UP"),
            onPressed: () => _onSignUpButtonPressed(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already have an account.", style: TextStyle(fontSize: 15),),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Login Now.", style: TextStyle(fontSize: 18),),
                ),
                splashColor: Theme.of(context).accentColor,
                onTap: () => _onLoginButtonPressed(context),
              )
            ],
          ),
        ],
      ),
    );
  }
}
