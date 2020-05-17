class ModuleFile {
  int _id;
  int get id => _id;

  String _name;
  String get name => _name;

  String _path;
  String get path => _path;

  String _type;
  String get type => _type;

  ModuleFile({int id, String name, String path, String type})
      : _id = id,
        _name = name,
        _path = path,
        _type = type;
}
