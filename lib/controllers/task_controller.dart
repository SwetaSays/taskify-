import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var filter = 'All'.obs;
  late Box<TaskModel> taskBox;

  @override
  void onInit() {
    super.onInit();
    taskBox = Hive.box<TaskModel>('tasks');
    tasks.addAll(taskBox.values);
  }

  void addTask(String title) {
    final task = TaskModel(title: title);
    taskBox.add(task);
    tasks.add(task);
  }

  void updateTask(int index, String newTitle) {
    tasks[index].title = newTitle;
    tasks[index].save();
    tasks.refresh();
  }

  void toggleStatus(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    tasks[index].save();
    tasks.refresh();
  }

  void deleteTask(int index) {
    tasks[index].delete();
    tasks.removeAt(index);
  }

  List<TaskModel> get filteredTasks {
    switch (filter.value) {
      case 'Active':
        return tasks.where((t) => !t.isDone).toList();
      case 'Completed':
        return tasks.where((t) => t.isDone).toList();
      default:
        return tasks;
    }
  }

  void setFilter(String value) {
    filter.value = value;
  }
}
