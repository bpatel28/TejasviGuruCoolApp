part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();
}

class SubjectInitial extends SubjectState {
  @override
  List<Object> get props => [];
}

class LoadingModules extends SubjectState {
  @override
  List<Object> get props => [];
}

class ModulesLoaded extends SubjectState {
  final List<StudyModule> modules;

  ModulesLoaded(this.modules);

  @override
  List<Object> get props => [modules];
}