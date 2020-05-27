part of 'module_bloc.dart';

abstract class ModuleState extends Equatable {
  const ModuleState();
}

class ModuleInitial extends ModuleState {
  @override
  List<Object> get props => [];
}

class LoadingItems extends ModuleState {
  @override
  List<Object> get props => [];
}

class ItemsLoaded extends ModuleState {
  final List<ModuleItem> items;

  ItemsLoaded(this.items);

  @override
  List<Object> get props => [items];
}