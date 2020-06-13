import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/subject/subject_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
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
  UserBloc _userBloc;
  SubjectBloc _subjectBloc;

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
    _userBloc = context.bloc<UserBloc>();
    _subjectBloc = context.bloc<SubjectBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("${_subject?.name}: Add New Module"),
      ),
      body: Column(
        children: [
          _getModuleCard(),
          _buildModuleAddForm(),
        ],
      ),
    );
  }

  Widget _buildModuleAddForm() {
    final SubjectState subjectState = _subjectBloc?.state;
    final UserState userState = _userBloc?.state;
    if (userState is AuthenticatedUser && subjectState is SubjectsLoaded) {
      return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
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
                _buildTextInput("URL", _moduleItemUrlController, _validateModuleItemUrl, (value) { }),
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
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _getModuleCard() {
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

  _onAddModuleClick(BuildContext context) {}

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

  @override
  void dispose() {
    super.dispose();
    _userBloc.close();
    _subjectBloc.close();
  }
}
