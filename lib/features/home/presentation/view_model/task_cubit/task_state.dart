import 'package:tasky_app/features/home/data/model/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<TaskModel> tasks;

  TaskSuccess({required this.tasks});
}

class TaskFailure extends TaskState {
  final String message;

  TaskFailure({required this.message});
}

class TaskActionLoading extends TaskState {}

class TaskActionSuccess extends TaskState {
  final String message;
  TaskActionSuccess({required this.message});
}

class TaskActionError extends TaskState {
  final String message;

  TaskActionError({required this.message});
}
