class User {
  String _id;
  String get id => _id;

  String _firstName;
  String get firstName => _firstName;

  String _lastName;
  String get lastName => _lastName;

  String _middleName;
  String get middleName => _middleName;

  DateTime _birthDate;
  DateTime get birthDate => _birthDate;

  String _phoneNo;
  String get phoneNo => _phoneNo;

  bool _isMember;
  bool get isMember => _isMember;

  String _email;
  String get email => _email;

  String _password;
  String get password => _password;

  DateTime _createdOn;
  DateTime get createdOn => _createdOn;

  DateTime _updatedOn;
  DateTime get updatedOn => _updatedOn;

  List<dynamic> _batches;
  List<dynamic> get batches => _batches;

  String _token;
  String get token => _token;

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
      {String id,
      String firstName,
      String lastName,
      String middleName,
      DateTime birthDate,
      String phoneNo,
      String email,
      String password,
      DateTime createdOn,
      DateTime updatedOn,
      bool isMember,
      String token,
      List<dynamic> batches})
      : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _middleName = middleName,
        _birthDate = birthDate,
        _phoneNo = phoneNo,
        _email = email,
        _password = password,
        _createdOn = createdOn,
        _updatedOn = updatedOn,
        _isMember = isMember,
        _token = token {
    _batches = batches ?? <dynamic>[];
  }
}
