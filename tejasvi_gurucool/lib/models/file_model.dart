class FileType {
  static const String VIDEO_FILE = "video";
  static const String IMAGE_FILE = "image";
  static const String PDF_FILE = "pdf";
}


class ModuleFile {
  String _id;
  String get id => _id;

  String _name;
  String get name => _name;

  String _path;
  String get path => _path;

  String _type;
  String get type => _type;

  bool isVideo() => FileType.VIDEO_FILE == _type;

  bool isImage() => FileType.IMAGE_FILE == _type;
  
  bool isPDF() => FileType.PDF_FILE == _type;

  ModuleFile({String id, String name, String path, String type})
      : _id = id,
        _name = name,
        _path = path,
        _type = type;
}
