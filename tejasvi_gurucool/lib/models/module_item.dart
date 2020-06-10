import 'package:tejasvi_gurucool/models/file_model.dart';
import 'package:tejasvi_gurucool/models/post_model.dart';

class ModuleItem {
  String _id;
  String get id => _id;

  String _title;
  String get title => _title;

  String _description;
  String get description => _description;

  ModuleFile _file;
  ModuleFile get file => _file;

  List<dynamic> _posts;
  List<dynamic> get posts => _posts;

  ModuleItem(
      {String id = "-1",
      String title = "",
      String description = "",
      ModuleFile file,
      List<dynamic> posts})
      : _id = id,
        _title = title,
        _description = description,
        _file = file {
    _posts = posts ?? <dynamic>[];
  }
}
