import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/repository/module_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final ModuleRepository _moduleRepository;

  ModuleBloc(this._moduleRepository);

  @override
  ModuleState get initialState => ModuleInitial();

  @override
  Stream<ModuleState> mapEventToState(
    ModuleEvent event,
  ) async* {
    if (event is FetchModuleItemsEvent) {
      yield LoadingItems();

      final List<ModuleItem> items = await _moduleRepository.getItems(event.moduleId);

      yield ItemsLoaded(items);
    }
  }
}
