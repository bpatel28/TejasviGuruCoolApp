part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();
}


class GetAllStudents extends StudentsEvent {
  @override
  List<Object> get props => [];
}

class ChangeMemberStatus extends StudentsEvent {
  final String userId;
  final bool value;

  ChangeMemberStatus(this.userId, this.value);

  @override
  List<Object> get props => [];
}