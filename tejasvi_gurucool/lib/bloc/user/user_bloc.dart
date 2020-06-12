import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository);

  @override
  UserState get initialState => LoggedOut();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoginUser) {
      yield LoginLoading();
      try {
        final user = await _userRepository.signInWithCredentials(
          email: event.email,
          password: event.password,
        );

        yield AuthenticatedUser(user);
      } on Exception catch (e) {
        print(e);
        yield LoginFailed("Login Failed");
      }
    } else if (event is RegisterUser) {
      yield RegisterLoading();
      try {
        final user = await _userRepository.registerUser(
          batches: event.batches,
          birthDate: event.birthDate,
          firstName: event.firstName,
          lastName: event.lastName,
          middleName: event.middleName,
          phoneNo: event.phoneNo,
          email: event.email,
          password: event.password,
        );

        yield AuthenticatedUser(user);
      } on Exception catch (e) {
        print(e);
        yield RegistrationFailed("Registration Failed");
      }
    } else if (event is LogOut) {
      yield LoggedOut();

      await _userRepository.signOut();
    } else if (event is ResetPassword) {
      yield ResetPasswordStarted();

      await _userRepository.resetPassword(event.email);

      yield ResetPasswordSent();
    }
  }
}
