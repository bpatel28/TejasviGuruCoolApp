import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
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
    if (event is FetchSubjects) {
      yield LoadingSubjects();

      final List<Subject> subjects = await _subjectRepository.getSubjects(event.batches);

      yield SubjectsLoaded(subjects);
    }

    else if (event is AddNewModuleItem) {
      yield LoadingAddNewModuleItem();

      await _subjectRepository.addNewModuleItem(event.subjectId, event.moduleItem);

      yield NewModuleItemAdded();
    }
  }
}
