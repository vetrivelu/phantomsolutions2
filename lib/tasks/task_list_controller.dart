import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:phantomsolutions2/firebase.dart';
import 'package:phantomsolutions2/models/task.dart';
import 'package:phantomsolutions2/tasks/task_list.dart';

class TaskListController extends ChangeNotifier {
  Query<Map<String, dynamic>> query = tasksRef;
  DateTime date = DateTime.now();
  reloadQuery() {
    tasks = [];
    selectedTasks = [];
    query = tasksRef.where('taskState', isEqualTo: TaskState.pending.index).orderBy('dueDate', descending: false);
    loadTasks();
  }

  TaskListController();

  List<Task> tasks = [];
  List<Task> selectedTasks = [];

  loadTasks() {
    print("loading tasks...");
    query.snapshots().listen((event) {
      tasks = event.docs.map((e) => Task.fromSnapshot(e)).toList();
      print(tasks.length);
      notifyListeners();
    }).onError((error) {
      print(error.toString());
    });
  }

  selectTask(Task task) {
    selectedTasks.add(task);
    notifyListeners();
  }
}
