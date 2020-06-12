import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';

class SubjectRepository {
  final Firestore _firestore;

  SubjectRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<List<Subject>> getSubjects(final List<String> batches) async {
    List<Subject> subjects = <Subject>[];
    for (var i = 0; i < batches.length; ++i) {
      final batchRef = batches[i];
      final DocumentSnapshot batchDoc =
          await _firestore.collection("batches").document(batchRef).get();
      final List<String> subjectDocIds =
          new List<String>.from(batchDoc.data["subjects"]);
      for (var j = 0; j < subjectDocIds.length; ++j) {
        final subjectDocId = subjectDocIds[j];
        final DocumentSnapshot subjectDoc = await _firestore
            .collection("subjects")
            .document(subjectDocId)
            .get();
        final subject = await _extractSubject(subjectDoc);
        if (subject != null) subjects.add(subject);
      }
    }
    return subjects;
  }

  Future<Subject> _extractSubject(DocumentSnapshot subjectDoc) async {
    final String subjectName = subjectDoc.data["name"] ?? "";
    final String subjectDescription = subjectDoc.data["description"] ?? "";
    final List<Map<dynamic, dynamic>> modulesData =
        new List<Map<dynamic, dynamic>>.from(subjectDoc.data["modules"]);
    final List<ModuleItem> studyModules = <ModuleItem>[];
    for (var i = 0; i < modulesData.length; ++i) {
      final moduleData = new Map<String, dynamic>.from(modulesData[i]);
      final studyModule = await _extractModule(i, moduleData);
      if (studyModule != null) studyModules.add(studyModule);
    }
    return new Subject(
      id: subjectDoc.documentID,
      name: subjectName,
      description: subjectDescription,
      modules: studyModules,
    );
  }

  Future<ModuleItem> _extractModule(
      int id, Map<String, dynamic> moduleData) async {
    final moduleName = moduleData["name"] ?? "";
    final moduleDescription = moduleData["description"] ?? "";
    final fileName = moduleData["fileName"] ?? "";
    final filePath = moduleData["filePath"] ?? "";
    final fileType = moduleData["fileType"] ?? "";
    return new ModuleItem(
      id: id,
      name: moduleName,
      description: moduleDescription,
      fileName: fileName,
      filePath: filePath,
      fileType: fileType,
    );
  }
}
