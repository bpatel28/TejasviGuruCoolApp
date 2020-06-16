import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/repository/subject_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final SubjectRepository _subjectRepository;

  ModuleBloc(this._subjectRepository);

  @override
  ModuleState get initialState => ModuleInitial();

  @override
  Stream<ModuleState> mapEventToState(
    ModuleEvent event,
  ) async* {
    if (event is AddNewModuleItem) {
      yield LoadingAddNewModuleItem();

      await _subjectRepository.addNewModuleItem(event.subjectId, event.moduleItem);

      yield NewModuleItemAdded();
    }
  }
}
