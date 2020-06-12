import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:tejasvi_gurucool/repository/user_repository.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final UserRepository _userRepository;

  StudentsBloc(this._userRepository);
  
  @override
  StudentsState get initialState => StudentsInitial();

  @override
  Stream<StudentsState> mapEventToState(
    StudentsEvent event,
  ) async* {
     if (event is GetAllStudents) {
      yield StudentsFetchLoading();

      final users = await _userRepository.getAllUsers();

      yield StudentsFetchComplete(users);
     } else if (event is ChangeMemberStatus) {
       yield StudentsFetchLoading();
       
       await _userRepository.changeMemberStatus(event.userId, event.value);

       final users = await _userRepository.getAllUsers();

       yield StudentsFetchComplete(users);
     }
  }
}
