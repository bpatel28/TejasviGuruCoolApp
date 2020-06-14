import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/subject/subject_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';

typedef void _OnChange(String value);

class AddModuleScreenArgs {
  final Subject subject;

  AddModuleScreenArgs(this.subject);
}

class AddModuleScreen extends StatefulWidget {
  @override
  _AddModuleState createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModuleScreen> {
  Subject _subject;
  String _name;
  String _description;

  final _formKey = GlobalKey<FormState>();
  final _moduleNameController = TextEditingController();
  final _moduleDescriptionController = TextEditingController();
  final _moduleItemUrlController = TextEditingController();

  void _onModuleNameChange(String value) {
    setState(() {
      _name = value;
    });
  }

  void _onModuleDescriptionChange(String value) {
    setState(() {
      _description = value;
    });
  }

  String _validateModuleName(String value) {
    if (value.isEmpty) {
      return "Module Name can not be empty.";
    }
    return null;
  }

  String _validateModuleItemUrl(String value) {
    if (value.isEmpty) {
      return "Url can not be empty.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AddModuleScreenArgs args = ModalRoute.of(context).settings.arguments;
    _subject = args.subject;
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("New Module"),
        ),
        body: ListView(
          children: [
            _getModuleCard(context),
            BlocBuilder<UserBloc, UserState>(
              builder: (BuildContext userblocContext, UserState userState) {
                if (userState is AuthenticatedUser) {
                  return BlocBuilder<SubjectBloc, SubjectState>(
                    builder: (BuildContext subjectblocContext,
                        SubjectState subjectState) {
                      if (subjectState is LoadingAddNewModuleItem) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (subjectState is NewModuleItemAdded) {
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                          context
                              .bloc<SubjectBloc>()
                              .add(FetchSubjects(userState.user.batches));
                        });
                        return Text("New Subject Added");
                      } else {
                        return _buildModuleAddForm(context);
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

  Widget _buildModuleAddForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Add new module for ${_subject.name}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.red),
              ),
              Text(
                _subject.description,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              _buildTextInput(
                "Name",
                _moduleNameController,
                _validateModuleName,
                _onModuleNameChange,
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildTextInput(
                "Description",
                _moduleDescriptionController,
                (value) => null,
                _onModuleDescriptionChange,
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildTextInput("URL", _moduleItemUrlController,
                  _validateModuleItemUrl, (value) {}),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                splashColor: Theme.of(context).accentColor,
                child: Text("Submit"),
                onPressed: () => _onAddModuleClick(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getModuleCard(BuildContext context) {
    final String name = _name ?? "Name";
    final String description = _description ?? "Description";
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.video_library,
              size: 30.0,
            ),
            SizedBox(
              width: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddModuleClick(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Add New Module for ${_subject?.name}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to add new module?'),
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
                final String name = _moduleNameController.text;
                final String description = _moduleDescriptionController.text;
                final String url = _moduleItemUrlController.text;
                final ModuleItem item = new ModuleItem(
                  name: name,
                  description: description,
                  filePath: url,
                  fileName: name,
                  fileType: "VIDEO",
                );
                context
                    .bloc<SubjectBloc>()
                    .add(AddNewModuleItem(_subject.id, item));
                Navigator.of(context).pop();
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
}
