import 'package:flutter/material.dart';
import 'package:todolist/model/task_model.dart';
import 'package:todolist/screens/add_edit_task_screen.dart';
import 'package:todolist/screens/task_history_screen.dart';
import 'package:todolist/screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = [];
    List<TaskModel> completedTasks = [];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            TaskListScreen(tasks: tasks, completedTasks: completedTasks),
        '/add_edit_task': (context) => const AddEditTaskScreen(),
        '/task_history': (context) =>
            TaskHistoryScreen(completedTasks: completedTasks),
      },
    );
  }
}
