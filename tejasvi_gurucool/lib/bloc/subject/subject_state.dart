part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();
}

class SubjectInitial extends SubjectState {
  @override
  List<Object> get props => [];
}

class LoadingSubjects extends SubjectState {
  @override
  List<Object> get props => [];
}

class SubjectsLoaded extends SubjectState {
  final List<Subject> subjects;

  SubjectsLoaded(this.subjects);

  @override
  List<Object> get props => [subjects];
}

class LoadingAddNewModuleItem extends SubjectState {
  @override
  List<Object> get props => [];
}

class NewModuleItemAdded extends SubjectState {
  @override
  List<Object> get props => [];
}
