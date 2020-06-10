import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/repository/batch_repository.dart';
import 'package:tejasvi_gurucool/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final BatchRepository _batchRepository;

  UserBloc(this._userRepository, this._batchRepository);

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

        final batches = await _batchRepository.getAllBatches();

        yield AuthenticatedUser(user, batches);
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
        final batches = await _batchRepository.getAllBatches();
        yield AuthenticatedUser(user, batches);
      } on Exception catch (e) {
        print(e);
        yield RegistrationFailed("Registration Failed");
      }
    } else if (event is LogOut) {
      yield LoggedOut();

      await _userRepository.signOut();
    }
  }
}
