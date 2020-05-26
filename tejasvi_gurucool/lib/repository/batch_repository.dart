import 'package:tejasvi_gurucool/mock_data.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';

class BatchRepository {
  Future<List<Batch>> getAllBatches() async {
    await Future.delayed(Duration(seconds: 1));
    return Mock.batches;
  }

  Future<List<Subject>> getSubjects(final List<int> batches) async {
    await Future.delayed(Duration(seconds: 2));
    return Mock.subjects;
  }
}