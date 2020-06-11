class ModuleItem {
  int _id;
  int get id => _id;

  String _name;
  String get name => _name;

  String _description;
  String get description => _description;

  String _fileName;
  String get fileName => _fileName;

  String _fileType;
  String get fileType => _fileType;

  String _filePath;
  String get filePath => _filePath;

  bool isImage() {
    return fileType.toUpperCase().contains("IMAGE");
  }

  bool isVideo() {
    return fileType.toUpperCase().contains("VIDEO");
  }

  bool isPDF() {
    return fileType.toUpperCase().contains("PDF");
  }

  ModuleItem({
    int id = -1,
    String name = "",
    String description = "",
    String fileName = "",
    String fileType = "",
    String filePath = "",
  })  : _id = id,
        _name = name,
        _description = description,
        _fileName = fileName,
        _fileType = fileType,
        _filePath = filePath;
}
