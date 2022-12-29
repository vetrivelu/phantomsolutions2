import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskState { pending, inprogress, cancelled, completed }

class Task {
  final DocumentReference reference;
  final String title;
  final String description;
  final DateTime dueDate;
  final DateTime modifiedOn;
  TaskState taskState;

  Task({
    required this.reference,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.modifiedOn,
    required this.taskState,
  });

  int get balance => DateTime.now().difference(dueDate).inDays;

  factory Task.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var json = snapshot.data();
    json!["reference"] = snapshot.reference;
    return Task.fromJson(json);
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      reference: json["reference"],
      title: json["title"],
      description: json["description"],
      dueDate: (json["dueDate"] as Timestamp).toDate(),
      modifiedOn: (json["modifiedOn"] as Timestamp).toDate(),
      taskState: TaskState.values.elementAt(json["taskState"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "title": title,
        "description": description,
        "dueDate": dueDate,
        "modifiedOn": DateTime.now(),
        "taskState": taskState.index,
      };
}
