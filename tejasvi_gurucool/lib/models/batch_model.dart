import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/announcement_model.dart';

class Batch {
  int _id;
  int get id => _id;

  String _name;
  String get name => _name;

  List<Announcement> _announcements = <Announcement>[];
  List<Announcement> get announcements => _announcements;

  List<Subject> _subjects;
  List<Subject> get subjects => _subjects;

  Batch(
      {int id,
      String name,
      List<Announcement> announcements,
      List<Subject> subjects})
      : _id = id,
        _name = name {
    _announcements = announcements ?? <Announcement>[];
    _subjects = subjects ?? <Subject>[];
  }
}
