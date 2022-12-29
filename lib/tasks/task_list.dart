import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phantomsolutions2/tasks/helper_functios.dart';
import 'package:phantomsolutions2/tasks/task_list_controller.dart';
import 'package:phantomsolutions2/tasks/task_screen.dart';
import 'package:phantomsolutions2/tasks/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.only(left: 30, top: 180),
                  color: Colors.transparent,
                  child: buildDiary(SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: const Center(
                      child: TaskScreen(),
                    ),
                  )),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          Colors.black,
          Colors.lightBlueAccent,
          Colors.white,
        ])),
        padding: const EdgeInsets.only(top: 60.0, left: 30),
        child: ChangeNotifierProvider(create: (context) {
          var controller = TaskListController();
          controller.reloadQuery();
          return controller;
        }, builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30.0,
                    child: Icon(Icons.list, size: 30.0, color: Colors.lightBlueAccent),
                  ),
                  Expanded(
                      child: ListTile(
                    title: Text(DateFormat('EEEEEEEE').format(DateTime.now())),
                    subtitle: Text(DateFormat.yMMMMd().format(DateTime.now())),
                  ))
                ],
              ),
              const SizedBox(height: 40),
              Text('Welcome !!!', style: Theme.of(context).textTheme.headline3!),
              const SizedBox(height: 40),
              Expanded(child: buildDiary(Expanded(child: Builder(builder: (context) {
                var listController = Provider.of<TaskListController>(context);
                return ListView.builder(
                    itemCount: listController.tasks.length,
                    itemBuilder: (context, index) {
                      var task = listController.tasks[index];
                      return TaskTile(task: task, isSelected: listController.selectedTasks.contains(task));
                    });
              })))),
            ],
          );
        }),
      ),
    );
  }
}
