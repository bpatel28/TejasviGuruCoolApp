import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';
import 'package:tejasvi_gurucool/repository/subject_repository.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository _subjectRepository;

  SubjectBloc(this._subjectRepository);

  @override
  SubjectState get initialState => SubjectInitial();

  @override
  Stream<SubjectState> mapEventToState(
    SubjectEvent event,
  ) async* {
    if (event is FetchModulesEvent) {
      yield LoadingModules();

      final List<StudyModule> modules = await _subjectRepository.getModules(event.subjectId);

      yield ModulesLoaded(modules);
    }
  }
}
