part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();
}

class FetchModulesEvent extends SubjectEvent {
  final int subjectId;

  FetchModulesEvent(this.subjectId);

   @override
  List<Object> get props => [subjectId];
}