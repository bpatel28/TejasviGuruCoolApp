import 'package:tejasvi_gurucool/models/module_item.dart';

class StudyModule {
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  String _shortDescription;
  String get shortDescription => _shortDescription;

  String _longDescription;
  String get longDescription => _longDescription;

  List<ModuleItem> _items = <ModuleItem>[];
  List<ModuleItem> get items => _items;

  StudyModule(
      {int id = -1,
      String title = "",
      String shortDescription = "",
      String longDescription = "",
      List<ModuleItem> items})
      : _id = id,
        _title = title,
        _shortDescription = shortDescription,
        _longDescription = longDescription;
}
