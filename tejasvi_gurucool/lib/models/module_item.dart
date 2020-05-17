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

  List<Post> _posts = <Post>[];
  List<Post> get posts => _posts;

  ModuleItem({int id = -1, String title = "", String description = "", ModuleFile file, List<Post> posts})
      : _id = id,
        _title = title,
        _description = description,
        _file = file,
        _posts = posts;
}
