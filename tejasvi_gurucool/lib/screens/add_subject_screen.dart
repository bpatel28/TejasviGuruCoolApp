import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/subject/subject_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

typedef void _OnChange(String value);

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubjectScreen> {
  UserBloc _userBloc;
  BatchBloc _batchBloc;
  SubjectBloc _subjectBloc;

  Batch _batch;
  String _name;
  String _description;

  final _formKey = GlobalKey<FormState>();
  final _subjectNameController = TextEditingController();
  final _subjectDescriptionController = TextEditingController();

  void _onSubjectNameChange(String value) {
    setState(() {
      _name = value;
    });
  }

  void _onSubjectDescriptionChange(String value) {
    setState(() {
      _description = value;
    });
  }

  String _validateSubjectName(String value) {
    if (value.isEmpty) {
      return "Subject Name can not be empty.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _userBloc = context.bloc<UserBloc>();
    _batchBloc = context.bloc<BatchBloc>();
    _subjectBloc = context.bloc<SubjectBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Subject"),
      ),
      body: Column(
        children: [
          _getSubjectCard(),
          _buildSubjectAddForm(),
        ],
      ),
    );
  }

  Widget _buildSubjectAddForm() {
    final BatchState batchState = _batchBloc?.state;
    final UserState userState = _userBloc?.state;
    if (userState is AuthenticatedUser && batchState is AllBatchLoaded) {
      return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                _buildBatchDropdown(
                  "Select Batch:",
                  batchState.batches,
                ),
                _buildTextInput(
                  "Name",
                  _subjectNameController,
                  _validateSubjectName,
                  _onSubjectNameChange,
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildTextInput(
                  "Description",
                  _subjectDescriptionController,
                  (value) => null,
                  _onSubjectDescriptionChange,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  splashColor: Theme.of(context).accentColor,
                  child: Text("Submit"),
                  onPressed: () => _onSubjectAddSubmit(context),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _getSubjectCard() {
    final String name = _name ?? "Name";
    final String description =
        (_batch?.name ?? "") + " "+ (_description ?? "Description");
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircularBox(
                  "0",
                  padding: EdgeInsets.all(10.0),
                  color: const Color(0xFFffa500),
                ),
              ],
            ),
            Text(description),
          ],
        ),
      ),
    );
  }

  void _onSubjectAddSubmit(BuildContext context) {}

  void showSnackBar(BuildContext context, message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Widget _buildTextInput(
    String label,
    TextEditingController controller,
    Function(String) validator,
    _OnChange onChange,
  ) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(labelText: label),
      onChanged: onChange,
    );
  }

  Widget _buildBatchDropdown(String label, List<Batch> batches) {
    return DropdownButton(
      icon: Icon(Icons.arrow_downward),
      value: _batch?.id,
      hint: Text(label),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: Colors.black),
      underline: Container(
        height: 2.0,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          _batch = batches.where((item) => item.id == newValue).first ?? null;
        });
      },
      items: batches.map<DropdownMenuItem<String>>((Batch batch) {
        return DropdownMenuItem(value: batch.id, child: Text(batch.name));
      }).toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userBloc.close();
    _batchBloc.close();
    _subjectBloc.close();
  }
}
