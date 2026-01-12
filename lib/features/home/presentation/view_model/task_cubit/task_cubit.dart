import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/domain/repositories/task_repository.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository taskRepository;
  DateTime? currentSelectedDate;

  TaskCubit({required this.taskRepository}) : super(TaskInitial());

  Future<void> getTasks({
    DateTime? date,
    String? search,
    bool clearDate = false,
  }) async {
    if (clearDate) {
      currentSelectedDate = null;
    } else if (date != null) {
      currentSelectedDate = date;
    }

    emit(TaskLoading());
    try {
      final tasks = await taskRepository.getTasks(
        date: currentSelectedDate,
        search: search,
        isCompleted: null,
      );
      emit(TaskSuccess(tasks: tasks));
    } catch (e) {
      emit(TaskFailure(message: e.toString()));
    }
  }

  Future<void> addTask(TaskModel taskModel) async {
    emit(TaskActionLoading());
    try {
      await taskRepository.addTask(taskModel);
      emit(TaskActionSuccess(message: "Task Added Successfully"));
      getTasks(); // Refresh list
    } catch (e) {
      emit(TaskActionError(message: e.toString()));
    }
  }

  Future<void> updateTask(
    TaskModel taskModel, {
    String message = "Task Updated Successfully",
  }) async {
    emit(TaskActionLoading());
    try {
      await taskRepository.updateTask(taskModel);
      emit(TaskActionSuccess(message: message));
      getTasks(); // Refresh list
    } catch (e) {
      emit(TaskActionError(message: e.toString()));
    }
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    emit(TaskActionLoading());
    try {
      await taskRepository.deleteTask(taskModel);
      emit(TaskActionSuccess(message: "Task Deleted Successfully"));
      getTasks(); // Refresh list
    } catch (e) {
      emit(TaskActionError(message: e.toString()));
    }
  }

  Future<void> toggleTask(TaskModel taskModel) async {
    taskModel.isCompleted = !(taskModel.isCompleted ?? false);
    final message = taskModel.isCompleted! ? "Task Completed" : "Task Active";
    await updateTask(taskModel, message: message);
  }
}
