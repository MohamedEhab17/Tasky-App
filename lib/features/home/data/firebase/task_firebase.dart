import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';

class TaskFirebase {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  TaskFirebase({required this.firestore, required this.auth});

  CollectionReference<TaskModel> getCollectionTask() {
    String id = auth.currentUser!.uid;
    return firestore
        .collection('Users')
        .withConverter<UserModel>(
          fromFirestore: (user, _) => UserModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .doc(id)
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (task, _) => TaskModel.fromJson(task.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  Future<void> addTask(TaskModel taskModel) async {
    taskModel.id = getCollectionTask().doc().id;
    await getCollectionTask().doc(taskModel.id.toString()).set(taskModel);
  }

  Future<void> updateTask(TaskModel taskModel) async {
    await getCollectionTask()
        .doc(taskModel.id.toString())
        .update(taskModel.toJson());
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    await getCollectionTask().doc(taskModel.id.toString()).delete();
  }

  
  Future<List<TaskModel>> getTasks({
  DateTime? date,
  String? search,
  bool? isCompleted,
}) async {
  Query<TaskModel> query = getCollectionTask();

  if (date != null) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

    query = query
        .where('date', isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch)
        .where('date', isLessThanOrEqualTo: endOfDay.millisecondsSinceEpoch);
        
  } else {
    if (isCompleted != null) {
      query = query.where('isCompleted', isEqualTo: isCompleted);
    }
  }

  final QuerySnapshot<TaskModel> snapshot = await query.get();
  List<TaskModel> taskList = snapshot.docs.map((e) => e.data()).toList();

  if (date != null && isCompleted != null) {
    taskList = taskList.where((task) => task.isCompleted == isCompleted).toList();
  }

  if (search != null && search.trim().isNotEmpty) {
    final queryStr = search.toLowerCase();
    taskList = taskList.where((task) {
      return (task.title ?? '').toLowerCase().contains(queryStr);
    }).toList();
  }

  taskList.sort((a, b) => (a.priority ?? 0).compareTo(b.priority ?? 0));

  return taskList;
}
}
