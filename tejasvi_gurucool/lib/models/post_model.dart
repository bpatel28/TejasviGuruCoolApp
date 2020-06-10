import 'package:tejasvi_gurucool/models/user_model.dart';

class Post {
  String _id;
  String get id => _id;

  String _text;
  String get text => _text;

  DateTime _timestamp;
  DateTime get timestamp => _timestamp;

  User _sender;
  User get sender => _sender;

  Post({String id = "-1", String text = "", DateTime timestamp, User sender})
      : _id = id,
        _text = text,
        _timestamp = timestamp,
        _sender = sender;
}
