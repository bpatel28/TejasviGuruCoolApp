import 'package:tejasvi_gurucool/models/module_item.dart';

class Subject {
  String _id;
  String get id => _id;

  String _name;
  String get name => _name;

  String _description;
  String get description => _description;

  List<ModuleItem> _modules;
  List<ModuleItem> get modules => _modules;

  Subject({
    String id = "-1",
    String name = "",
    String description = "",
    List<ModuleItem> modules,
  })  : _id = id,
        _name = name,
        _description = description {
    _modules = modules ?? <ModuleItem>[];
  }
}
