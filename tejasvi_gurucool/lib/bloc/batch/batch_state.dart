part of 'batch_bloc.dart';

abstract class BatchState extends Equatable {
  const BatchState();
}

class BatchInitial extends BatchState {
  @override
  List<Object> get props => [];
}

class AllBatchLoaded extends BatchState {
  final List<Batch> batches;

  AllBatchLoaded(this.batches);

  @override
  List<Object> get props => [batches];
}

class LoadingBatchesList extends BatchState {
  @override
  List<Object> get props => [];
}

class LoadingSubjectAdd extends BatchState {
  @override
  List<Object> get props => [];
}

class SubjectAdded extends BatchState {
  @override
  List<Object> get props => [];
}