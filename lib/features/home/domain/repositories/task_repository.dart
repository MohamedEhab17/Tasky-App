import 'package:tasky_app/features/home/data/model/task_model.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskModel taskModel);
  Future<void> updateTask(TaskModel taskModel);
  Future<void> deleteTask(TaskModel taskModel);
  Future<List<TaskModel>> getTasks({
    DateTime? date,
    String? search,
    bool? isCompleted,
  });
}
