import 'package:tejasvi_gurucool/models/study_module_model.dart';

class Subject {
  String _id;
  String get id => _id;

  String _name;
  String get name => _name;

  String _description;
  String get description => _description;

  List<StudyModule> _modules;
  List<StudyModule> get modules => _modules;

  Subject({
    String id = "-1",
    String name = "",
    String description = "",
    List<StudyModule> modules,
  })  : _id = id,
        _name = name,
        _description = description {
    _modules = modules ?? <StudyModule>[];
  }
}
