part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();
}

class FetchSubjects extends SubjectEvent {
  final List<String> batches;

  FetchSubjects(this.batches);

   @override
  List<Object> get props => [batches];
}