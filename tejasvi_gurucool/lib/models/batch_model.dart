import 'package:tejasvi_gurucool/models/announcement_model.dart';

class Batch {
  String _id;
  String get id => _id;

  String _name;
  String get name => _name;

  List<Announcement> _announcements = <Announcement>[];
  List<Announcement> get announcements => _announcements;

  List<String> _subjects;
  List<String> get subjects => _subjects;

  Batch(
      {String id,
      String name,
      List<Announcement> announcements,
      List<String> subjects})
      : _id = id,
        _name = name {
    _announcements = announcements ?? <Announcement>[];
    _subjects = subjects ?? <String>[];
  }
}
