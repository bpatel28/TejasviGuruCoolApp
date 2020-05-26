import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/repository/batch_repository.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final BatchRepository _batchRepository;

  BatchBloc(this._batchRepository);

  @override
  BatchState get initialState => BatchInitial();

  @override
  Stream<BatchState> mapEventToState(
    BatchEvent event,
  ) async* {
    if (event is FetchBatches) {
      yield LoadingBatchesList();

      final List<Batch> batches = await _batchRepository.getAllBatches();

      yield AllBatchLoaded(batches);
    }

    if (event is FetchSubjects) {
      yield LoadingSubjects();

      final List<Subject> subjects = await _batchRepository.getSubjects(event.batches);

      yield SubjectsLoaded(subjects);
    }
  }
}
