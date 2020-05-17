import 'package:tejasvi_gurucool/models/study_module_model.dart';

class Subject {
  int _id;
  int get id => _id;

  String _name;
  String get name => _name;

  String _description;
  String get description => _description;

  List<StudyModule> _modules;
  List<StudyModule> get modules => _modules;

  Subject({id, name, description, modules})
      : _id = id,
        _name = name,
        _description = description,
        _modules = modules;
}
