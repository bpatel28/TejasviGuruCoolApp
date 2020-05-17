import 'package:tejasvi_gurucool/models/study_module_model.dart';

class Subject {
  int _id;
  int get id => _id;

  String _name;
  String get name => _name;

  String _description;
  String get description => _description;

  List<StudyModule> _modules = <StudyModule>[];
  List<StudyModule> get modules => _modules;

  Subject({int id = -1, String name = "", String description = "", List<StudyModule> modules})
      : _id = id,
        _name = name,
        _description = description,
        _modules = modules;
}
