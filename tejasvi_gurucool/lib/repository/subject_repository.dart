import 'package:tejasvi_gurucool/mock_data.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';

class SubjectRepository {
  Future<List<StudyModule>> getModules(final String subjectId) async {
    await Future.delayed(Duration(seconds: 2));
    List<StudyModule> modules = <StudyModule> [];
    Mock.subjects.where((subject) => subject.id == subjectId).first.modules.forEach((moduleId) {
      StudyModule module = Mock.modules.where((item) => item.id == moduleId).first;
      if (module != null) modules.add(module);
    });
    return modules;
  }
}