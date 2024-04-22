import 'package:flutter/material.dart';
import 'package:todolist/model/task_model.dart';
import 'package:todolist/screens/add_edit_task_screen.dart';
import 'package:todolist/screens/task_history_screen.dart';

class TaskListScreen extends StatefulWidget {
  final List<TaskModel> tasks;
  final List<TaskModel> completedTasks;

  const TaskListScreen(
      {Key? key, required this.tasks, required this.completedTasks})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<TaskModel> _tasks = [];

  @override
  void initState() {
    super.initState();
    _tasks = List<TaskModel>.from(widget.tasks);
    _sortTasksByDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TaskHistoryScreen(completedTasks: widget.completedTasks),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return _buildTaskItem(_tasks[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddTaskScreen(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskItem(TaskModel task) {
    return ListTile(
      title: Text(task.description),
      subtitle: Text(task.dateTime.toString()),
      trailing: Checkbox(
        value: task.completed,
        onChanged: (value) {
          _showConfirmDialog(task, value!);
        },
      ),
    );
  }

  Future<void> _navigateToAddTaskScreen(BuildContext context) async {
    final newTask = await Navigator.push<TaskModel?>(
      context,
      MaterialPageRoute(builder: (context) => const AddEditTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        _tasks.add(newTask);
        _sortTasksByDateTime();
      });
    }
  }

  void _sortTasksByDateTime() {
    _tasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  Future<void> _showConfirmDialog(TaskModel task, bool newValue) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(newValue ? 'Finalizar Tarefa' : 'Reabrir Tarefa'),
          content: Text(newValue
              ? 'Tem certeza de que deseja finalizar esta tarefa?'
              : 'Tem certeza de que deseja reabrir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  task.completed = newValue;
                  if (newValue) {
                    widget.completedTasks.add(task);
                    _tasks.remove(task);
                  } else {
                    _sortTasksByDateTime();
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text(newValue ? 'Finalizar' : 'Reabrir'),
            ),
          ],
        );
      },
    );
  }
}
