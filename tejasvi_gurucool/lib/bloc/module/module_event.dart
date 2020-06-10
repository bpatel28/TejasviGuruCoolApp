part of 'module_bloc.dart';

abstract class ModuleEvent extends Equatable {
  const ModuleEvent();
}

class FetchModuleItemsEvent extends ModuleEvent {
  final String moduleId;

  FetchModuleItemsEvent(this.moduleId);

   @override
  List<Object> get props => [moduleId];
}