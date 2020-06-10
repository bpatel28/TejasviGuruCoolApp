import 'package:tejasvi_gurucool/models/post_model.dart';

class ModuleItem {
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  String _description;
  String get description => _description;

  String _fileName;
  String get fileName => _fileName;

  String _fileType;
  String get fileType => _fileType;

  String _filePath;
  String get filePath => _filePath;

  List<Post> _posts;
  List<Post> get posts => _posts;

  bool isImage() {
    return fileType.toUpperCase().contains("IMAGE");
  }

  bool isVideo() {
    return fileType.toLowerCase().contains("VIDEO");
  }

  bool isPDF() {
    return fileType.toLowerCase().contains("PDF");
  }

  ModuleItem({
    int id = -1,
    String title = "",
    String description = "",
    String fileName = "",
    String fileType = "",
    String filePath = "",
    List<Post> posts,
  })  : _id = id,
        _title = title,
        _description = description,
        _fileName = fileName,
        _fileType = fileType,
        _filePath = filePath {
    _posts = posts ?? <Post>[];
  }
}
