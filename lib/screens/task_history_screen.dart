import 'package:flutter/material.dart';
import 'package:todolist/model/task_model.dart';

class TaskHistoryScreen extends StatelessWidget {
  final List<TaskModel> completedTasks;

  const TaskHistoryScreen({Key? key, required this.completedTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(completedTasks[index].description),
            subtitle: Text(completedTasks[index].dateTime.toString()),
          );
        },
      ),
    );
  }
}
