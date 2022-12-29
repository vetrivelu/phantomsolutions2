import 'package:flutter/material.dart';
import 'package:phantomsolutions2/models/task.dart';
import 'package:phantomsolutions2/tasks/helper_functios.dart';
import 'package:phantomsolutions2/tasks/task_list_controller.dart';
import 'package:phantomsolutions2/tasks/task_screen.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.isSelected});

  final Task task;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var listController = Provider.of<TaskListController>(context);

    return Card(
      child: Row(
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            duration: const Duration(milliseconds: 200),
            height: isSelected ? 60 : 0,
            width: isSelected ? 16 : 0,
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  isThreeLine: true,
                  trailing: Text(task.balance.toString()),
                  onTap: () {
                    showModalBottomSheet(
                      // isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.only(left: 30),
                          color: Colors.transparent,
                          child: buildDiary(SizedBox(
                            width: MediaQuery.of(context).size.width - 70,
                            child: Center(
                              child: TaskScreen(task: task),
                            ),
                          )),
                        );
                      },
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (isSelected) {
                            listController.selectedTasks.remove(task);
                          } else {
                            listController.selectTask(task);
                          }
                          listController.notifyListeners();
                        },
                        child: Text(isSelected ? "Unselect" : "Select")),
                    ElevatedButton(
                        onPressed: () {
                          task.taskState = TaskState.completed;
                          task.reference.update(task.toJson());
                          listController.reloadQuery();
                        },
                        child: const Text("Completed")),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
