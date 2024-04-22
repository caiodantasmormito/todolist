import 'package:flutter/material.dart';
import 'package:todolist/model/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.description),
      subtitle: Text(widget.task.dateTime.toString()),
      trailing: Checkbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value!;
            widget.task.completed = value;
          });
        },
      ),
    );
  }
}
