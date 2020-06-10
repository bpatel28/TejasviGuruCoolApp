class StudyModule {
  String _id;
  String get id => _id;

  String _title;
  String get title => _title;

  String _shortDescription;
  String get shortDescription => _shortDescription;

  String _longDescription;
  String get longDescription => _longDescription;

  List<dynamic> _items = <String>[];
  List<dynamic> get items => _items;

  StudyModule(
      {String id = "-1",
      String title = "",
      String shortDescription = "",
      String longDescription = "",
      List<dynamic> items})
      : _id = id,
        _title = title,
        _shortDescription = shortDescription,
        _longDescription = longDescription {
    _items = items ?? <dynamic>[];
  }
}
