part of 'batch_bloc.dart';

abstract class BatchEvent extends Equatable {
  const BatchEvent();
}

class FetchBatches extends BatchEvent {
  @override
  List<Object> get props => [];
}

class FetchSubjects extends BatchEvent {
  final List<DocumentReference> batches;

  FetchSubjects(this.batches);

   @override
  List<Object> get props => [batches];
}