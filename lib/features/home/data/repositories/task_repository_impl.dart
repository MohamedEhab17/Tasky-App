import 'package:tasky_app/features/home/data/firebase/task_firebase.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskFirebase taskFirebase;

  TaskRepositoryImpl({required this.taskFirebase});

  @override
  Future<void> addTask(TaskModel taskModel) async {
    await taskFirebase.addTask(taskModel);
  }

  @override
  Future<void> deleteTask(TaskModel taskModel) async {
    await taskFirebase.deleteTask(taskModel);
  }

  @override
  Future<List<TaskModel>> getTasks({
    DateTime? date,
    String? search,
    bool? isCompleted,
  }) {
    return taskFirebase.getTasks(
      date: date,
      search: search,
      isCompleted: isCompleted,
    );
  }

  @override
  Future<void> updateTask(TaskModel taskModel) async {
    await taskFirebase.updateTask(taskModel);
  }
}
