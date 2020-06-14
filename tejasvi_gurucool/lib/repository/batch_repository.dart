import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tejasvi_gurucool/models/batch_model.dart';

class BatchRepository {
  final Firestore _firestore;

  BatchRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<List<Batch>> getAllBatches() async {
    final QuerySnapshot result =
        await _firestore.collection("batches").getDocuments();
    final List<DocumentSnapshot> docs = result.documents;

    final List<Batch> batches = <Batch>[];

    docs.forEach((doc) {
      final name = doc.data["name"] ?? "";
      final subjects =
          new List<String>.from(doc.data["subjects"]) ?? <String>[];
      batches
          .add(new Batch(id: doc.documentID, name: name, subjects: subjects));
    });

    return batches;
  }

  Future<void> addSubject(String batchId, String subjectId) async {
    await _firestore.collection("batches").document(batchId).updateData({
      "subjects" : FieldValue.arrayUnion(<String>[subjectId]),
    });
  }
}
