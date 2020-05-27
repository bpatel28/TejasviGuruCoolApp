import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';

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
  Batch batch;
  bool _batchLoaded = false;

  bool _passwordVisible = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthDateController = TextEditingController();

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

  String _validateBirthDate(String value) {
    if (value.isEmpty) {
      return "Enter Birth Date.";
    }
    if (DateTime.tryParse(value) == null) {
      return "Invalid format for date. please enter in format yyyy-dd-mm.";
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

  void _onSignUpButtonPressed(BuildContext context, UserBloc bloc) async {
    if (!_formKey.currentState.validate()) return;
    if (batch == null) {
      showSnackBar(context, "Please select batch.");
      return;
    }
    try {
      final String firstName = _firstNameController.text;
      final String lastName = _lastNameController.text;
      final String middleName = _middleNameController.text;
      final int phoneNo = int.tryParse(_phoneNoController.text);
      final DateTime birthDate = DateTime.tryParse(_birthDateController.text);
      final String username = _usernameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      bloc.add(RegisterUser(
        batches: <int>[batch.id],
        birthDate: birthDate,
        email: email,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        password: password,
        phoneNo: phoneNo,
        username: username,
      ));
    } on Exception catch (e) {
      print(e);
      showSnackBar(context, "Login Failed. Please try again");
    }
  }

  void _onLoginButtonPressed(context) {
    Future.delayed(Duration.zero, () => Navigator.pop(context));
  }

  @override
  build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state is AuthenticatedUser) {
          return _buildRegistrationComplete(context, state.user);
        } else if (state is RegisterLoading) {
          return _buildLoading(context);
        } else if (state is RegistrationFailed) {
          showSnackBar(context, state.message);
          return _buildRegistrationForm();
        } else {
          return _buildRegistrationForm();
        }
      },
    );
  }

  Widget _buildBatchesDropDown(List<Batch> batches) {
    return DropdownButton(
      icon: Icon(Icons.arrow_downward),
      value: batch?.id ?? null,
      hint: Text("Selct Batch"),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2.0,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int newValue) {
        setState(() {
          batch =
              batches.where((item) => item.id == newValue).first ?? null;
        });
      },
      items: batches.map<DropdownMenuItem<int>>((Batch batch) {
        return DropdownMenuItem(value: batch.id, child: Text(batch.name));
      }).toList(),
    );
  }

  Widget _buildLoadingBatches(BuildContext context, BatchBloc bloc) {
    if (!_batchLoaded) {
      _batchLoaded = true;
      bloc.add(FetchBatches());
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildRegistrationForm() {
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
            controller: _birthDateController,
            validator: _validateBirthDate,
            decoration: InputDecoration(
                labelText: "Enter Birth Date: yyyy-mm-dd",
                border: OutlineInputBorder()),
            keyboardType: TextInputType.datetime,
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
            height: 5,
          ),
          BlocBuilder<BatchBloc, BatchState>(
            builder: (BuildContext context, BatchState state) {
              if (state is AllBatchLoaded) {
                return _buildBatchesDropDown(state.batches);
              } else {
                return _buildLoadingBatches(context, context.bloc());
              }
            },
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            splashColor: Theme.of(context).accentColor,
            child: Text("SIGN UP"),
            onPressed: () => _onSignUpButtonPressed(context, context.bloc()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Already have an account.",
                style: TextStyle(fontSize: 15),
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Login Now.",
                    style: TextStyle(fontSize: 18),
                  ),
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

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildRegistrationComplete(BuildContext context, User user) {
    Future.delayed(
        Duration.zero, () => Navigator.pushNamed(context, Routes.SUBJECTS));
    return Center(
      child: Text("Registration Successful"),
    );
  }
}
