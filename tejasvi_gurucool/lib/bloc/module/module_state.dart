part of 'module_bloc.dart';

abstract class ModuleState extends Equatable {
  const ModuleState();
}

class ModuleInitial extends ModuleState {
  @override
  List<Object> get props => [];
}

class LoadingAddNewModuleItem extends ModuleState {
  @override
  List<Object> get props => [];
}

class NewModuleItemAdded extends ModuleState {
  @override
  List<Object> get props => [];
}
