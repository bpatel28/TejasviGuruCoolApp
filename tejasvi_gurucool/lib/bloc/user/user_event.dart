part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class RegisterUser extends UserEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String middleName;
  final DateTime birthDate;
  final String phoneNo;
  final List<String> batches;

  RegisterUser({
    @required this.firstName,
    @required this.lastName,
    @required this.middleName,
    @required this.birthDate,
    @required this.phoneNo,
    @required this.email,
    @required this.password,
    @required this.batches,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        middleName,
        birthDate,
        batches,
        email,
        password,
        phoneNo,
      ];
}
