import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/repository/batch_repository.dart';
import 'package:tejasvi_gurucool/repository/subject_repository.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final BatchRepository _batchRepository;
  final SubjectRepository _subjectRepository;

  BatchBloc(this._batchRepository, this._subjectRepository);

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
    } else if (event is AddSubject) {
      yield LoadingSubjectAdd();

      final String subjectId = await _subjectRepository.addNewSubject(event.subject);

      await _batchRepository.addSubject(event.batchId, subjectId);

      yield SubjectAdded();
    }
  }
}
