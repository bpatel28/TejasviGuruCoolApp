part of 'batch_bloc.dart';

abstract class BatchEvent extends Equatable {
  const BatchEvent();
}

class FetchBatches extends BatchEvent {
  @override
  List<Object> get props => [];
}

class AddSubject extends BatchEvent {
  final Subject subject;
  final String batchId;

  AddSubject(this.batchId, this.subject);

  @override
  List<Object> get props => [subject, batchId];
}