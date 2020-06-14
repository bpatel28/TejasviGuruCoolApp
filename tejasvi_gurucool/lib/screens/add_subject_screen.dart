import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/subject/subject_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/widgets/circular_box.dart';

typedef void _OnChange(String value);

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubjectScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: [
            _getSubjectCard(context),
            BlocBuilder<UserBloc, UserState>(
              builder: (BuildContext userblocContext, UserState userState) {
                if (userState is AuthenticatedUser) {
                  return BlocBuilder<BatchBloc, BatchState>(
                    builder:
                        (BuildContext batchblocContext, BatchState batchState) {
                      if (batchState is BatchInitial) {
                        Future.delayed(Duration.zero, () {
                          context.bloc<BatchBloc>().add(FetchBatches());
                        });
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (batchState is AllBatchLoaded) {
                        return _buildSubjectAddForm(
                            context, batchState.batches);
                      } else if (batchState is LoadingSubjectAdd) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (batchState is SubjectAdded) {
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                          context
                              .bloc<SubjectBloc>()
                              .add(FetchSubjects(userState.user.batches));
                          context.bloc<BatchBloc>().add(FetchBatches());
                        });
                        return Text("New Subject Added");
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectAddForm(BuildContext context, List<Batch> batches) {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                _batch == null
                    ? "Add new subject"
                    : "Add new subject for ${_batch?.name}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.red),
              ),
              _buildBatchDropdown(
                "Select Batch:",
                batches,
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
  }

  Widget _getSubjectCard(BuildContext context) {
    final String name = _name ?? "Name";
    final String description =
        (_batch?.name ?? "") + " " + (_description ?? "Description");
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

  Future<void> _onSubjectAddSubmit(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    if (_batch == null) {
      showSnackBar(context, "Please select batch.");
      return;
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Add New subject for ${_batch?.name}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to add new subject?'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Approve'),
              color: Colors.green,
              textColor: Colors.white,
              splashColor: Theme.of(context).primaryColor,
              onPressed: () {
                final String name = _subjectNameController.text;
                final String description =
                    _batch.name + " " + _subjectDescriptionController.text;
                final String batchId = _batch.id;
                final Subject subject =
                    new Subject(name: name, description: description);
                context.bloc<BatchBloc>().add(AddSubject(batchId, subject));
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pop();
                });
              },
            ),
            RaisedButton(
              child: Text('Cancel'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              splashColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(BuildContext context, message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
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
}
