import 'package:tejasvi_gurucool/mock_data.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';

class ModuleRepository {
  Future<List<ModuleItem>> getItems(final int moduleId) async {
    await Future.delayed(Duration(seconds: 1));
    List<ModuleItem> modules = <ModuleItem> [];
    Mock.modules.where((module) => module.id == moduleId).first.items.forEach((moduleItemId) {
      ModuleItem moduleItem = Mock.moduleItems.where((item) => item.id == moduleItemId).first;
      if (moduleItem != null) modules.add(moduleItem);
    });
    return modules;
  }
}