part of 'students_bloc.dart';

abstract class StudentsState extends Equatable {
  const StudentsState();
}

class StudentsInitial extends StudentsState {
  @override
  List<Object> get props => [];
}

class StudentsFetchLoading extends StudentsState {
  @override
  List<Object> get props => [];
}

class StudentsFetchComplete extends StudentsState {
  final List<User> users;

  StudentsFetchComplete(this.users);

  @override
  List<Object> get props => [users];
}
