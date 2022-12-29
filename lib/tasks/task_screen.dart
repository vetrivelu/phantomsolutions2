import 'package:flutter/material.dart';
import 'package:phantomsolutions2/models/task.dart';
import 'package:phantomsolutions2/tasks/helper_functios.dart';
import 'package:phantomsolutions2/tasks/task_form_controller.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, this.task});
  final Task? task;
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    if (widget.task != null) {
      controller = TaskFormController.fromTask(widget.task!);
    } else {
      controller = TaskFormController();
    }
    super.initState();
  }

  late TaskFormController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(20)),
                const Text(
                  'Add Task',
                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                ListTile(
                  title: const Text("Subject"),
                  subtitle: TextField(
                    controller: controller.title,
                  ),
                ),
                ListTile(
                  title: const Text("Description"),
                  subtitle: TextField(
                    controller: controller.description,
                  ),
                ),
                ListTile(
                  title: const Text("Date"),
                  subtitle: DateField(
                      date: controller.dueDate,
                      validator: (val) {
                        if (controller.dueDate == null) {
                          return "Date should not be empty";
                        }
                      },
                      onTap: (date) {
                        controller.dueDate = date;
                        print("date : ${controller.dueDate}");
                      }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var task = controller.task;
                      task.reference
                          .set(task.toJson())
                          .then((value) => print("Task created"))
                          .onError((error, stackTrace) => print(error.toString()));
                    }
                  },
                  child: Text(
                    controller.formMode == FormMode.create ? "ADD" : "EDIT",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
