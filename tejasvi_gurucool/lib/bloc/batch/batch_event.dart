part of 'batch_bloc.dart';

abstract class BatchEvent extends Equatable {
  const BatchEvent();
}

class FetchBatches extends BatchEvent {
  @override
  List<Object> get props => [];
}