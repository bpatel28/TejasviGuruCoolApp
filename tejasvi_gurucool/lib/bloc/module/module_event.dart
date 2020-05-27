part of 'module_bloc.dart';

abstract class ModuleEvent extends Equatable {
  const ModuleEvent();
}

class FetchModuleItemsEvent extends ModuleEvent {
  final int moduleId;

  FetchModuleItemsEvent(this.moduleId);

   @override
  List<Object> get props => [moduleId];
}