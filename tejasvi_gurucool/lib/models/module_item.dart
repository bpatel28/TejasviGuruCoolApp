import 'package:tejasvi_gurucool/models/file_model.dart';
import 'package:tejasvi_gurucool/models/post_model.dart';

class ModuleItem {
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  String _description;
  String get description => _description;

  ModuleFile _file;
  ModuleFile get file => _file;

  List<Post> _posts;
  List<Post> get posts => _posts;

  ModuleItem({id, title, description, file, posts})
      : _id = id,
        _title = title,
        _description = description,
        _file = file,
        _posts = posts;
}
