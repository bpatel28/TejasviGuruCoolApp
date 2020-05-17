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

  List<ModuleItem> _items;
  List<ModuleItem> get items => _items;

  StudyModule({id, title, shortDescription, longDescription, items})
      : _id = id,
        _title = title,
        _shortDescription = shortDescription,
        _longDescription = longDescription;
}
