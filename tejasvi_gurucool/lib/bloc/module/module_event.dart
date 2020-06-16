part of 'module_bloc.dart';

abstract class ModuleEvent extends Equatable {
  const ModuleEvent();
}


class AddNewModuleItem extends ModuleEvent {
  final String subjectId;
  final ModuleItem moduleItem;

  AddNewModuleItem(this.subjectId, this.moduleItem);

  @override
  List<Object> get props => [moduleItem];
}