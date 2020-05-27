part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoginUser extends UserEvent {
  final String username;
  final String password;

  LoginUser({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class RegisterUser extends UserEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String middleName;
  final DateTime birthDate;
  final int phoneNo;
  final String username;
  final List<int> batches;

  RegisterUser(
      {@required this.firstName,
      @required this.lastName,
      @required this.middleName,
      @required this.birthDate,
      @required this.phoneNo,
      @required this.username,
      @required this.email,
      @required this.password,
      @required this.batches});

  @override
  List<Object> get props => [
        firstName,
        lastName,
        middleName,
        username,
        birthDate,
        batches,
        email,
        password
      ];
}
