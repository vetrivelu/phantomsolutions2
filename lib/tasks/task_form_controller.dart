import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:phantomsolutions2/firebase.dart';
import 'package:phantomsolutions2/models/task.dart';

enum FormMode { create, update }

class TaskFormController {
  final title = TextEditingController();
  final description = TextEditingController();

  DocumentReference? _reference;
  DocumentReference get reference => _reference ?? tasksRef.doc();
  FormMode formMode = FormMode.create;

  DateTime? dueDate;
  DateTime? modifiedOn;
  TaskState taskState = TaskState.pending;

  Task get task => Task(
        reference: reference,
        title: title.text.trim(),
        description: description.text.trim(),
        dueDate: dueDate!,
        modifiedOn: DateTime.now(),
        taskState: taskState,
      );

  TaskFormController();
  factory TaskFormController.fromTask(Task task) {
    var controller = TaskFormController();
    controller._reference = task.reference;
    controller.title.text = task.title;
    controller.description.text = task.description;
    controller.dueDate = task.dueDate;
    controller.modifiedOn = task.modifiedOn;
    controller.taskState = task.taskState;
    return controller;
  }
}
