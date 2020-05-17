import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/screens/announcements_screen.dart';

class Batch {
  int _id;
  int get id => _id;

  String _name;
  String get name => _name;

  List<Announcement> _announcements;
  List<Announcement> get announcements => _announcements;

  List<Subject> _subjects;
  List<Subject> get subjects => _subjects;

  Batch({id, name, announcements, subjects})
      : _id = id,
        _name = name,
        _announcements = announcements,
        _subjects = subjects;
}
