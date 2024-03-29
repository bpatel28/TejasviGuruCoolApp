part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class LoggedOut extends UserState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends UserState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends UserState {
  final String message;

  LoginFailed(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterLoading extends UserState {
  @override
  List<Object> get props => [];
}

class RegistrationFailed extends UserState {
  final String message;

  RegistrationFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticatedUser extends UserState {
  final User user;

  AuthenticatedUser(this.user);

  @override
  List<Object> get props => [user];
}

class ResetPasswordStarted extends UserState {
  @override
  List<Object> get props => [];
}

class ResetPasswordSent extends UserState {
  @override
  List<Object> get props => [];
}
