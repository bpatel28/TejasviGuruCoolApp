import 'package:tejasvi_gurucool/models/batch_model.dart';

class User {
  int _id;
  int get id => _id;

  String _firstName;
  String get firstName => _firstName;

  String _lastName;
  String get lastName => _lastName;

  String _middleName;
  String get middleName => _middleName;

  DateTime _birthDate;
  DateTime get birthDate => _birthDate;

  int _phoneNo;
  int get phoneNo => _phoneNo;

  String _username;
  String get username => _username;

  String _email;
  String get email => _email;

  String _password;
  String get password => _password;

  DateTime _createdOn;
  DateTime get createdOn => _createdOn;

  DateTime _updatedOn;
  DateTime get updatedOn => _updatedOn;

  List<Batch> _batches;
  List<Batch> get batches => _batches;

  String getInitials() {
    try {
      return _firstName[0].toUpperCase() + _lastName[0].toUpperCase();
    } on Exception catch (e) {
      print(e.toString());
      return "";
    }
  }

  String getName() {
    try {
      return _firstName[0].toUpperCase() +
          _firstName.substring(1) +
          " " +
          _lastName[0].toUpperCase() +
          _lastName.substring(1);
    } on Exception catch (e) {
      print(e.toString());
      return "";
    }
  }

  String getFullName() {
    try {
      return _firstName[0].toUpperCase() +
          _firstName.substring(1) +
          " " +
          (_middleName.length > 0
              ? _middleName[0].toUpperCase() + _middleName.substring(1) + " "
              : "") +
          _lastName[0].toUpperCase() +
          _lastName.substring(1);
    } on Exception catch (e) {
      print(e.toString());
      return "";
    }
  }

  User(
      {int id,
      String firstName,
      String lastName,
      String middleName,
      DateTime birthDate,
      int phoneNo,
      String username,
      String email,
      String password,
      DateTime createdOn,
      DateTime updatedOn,
      List<Batch> batches})
      : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _middleName = middleName,
        _birthDate = birthDate,
        _phoneNo = phoneNo,
        _username = username,
        _email = email,
        _password = password,
        _createdOn = createdOn,
        _updatedOn = updatedOn,
        _batches = batches;
}
