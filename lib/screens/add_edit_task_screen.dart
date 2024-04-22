import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/model/task_model.dart';

class AddEditTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  // ignore: library_private_types_in_public_api
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  int _selectedPriority = 1;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    if (widget.task != null) {
      _selectedDateTime = widget.task!.dateTime;
      _selectedPriority = widget.task!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar/Editar Tarefa'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Text(
                      'Data/Hora: ${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDateTime)}'),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _selectDateTime(context);
                    },
                    child: const Text('Selecionar'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField(
                value: _selectedPriority,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Baixa')),
                  DropdownMenuItem(value: 2, child: Text('Média')),
                  DropdownMenuItem(value: 3, child: Text('Alta')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Prioridade'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _saveTask();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveTask() {
    final String description = _descriptionController.text.trim();

    if (description.isNotEmpty) {
      final TaskModel newTask = TaskModel(
        description: description,
        dateTime: _selectedDateTime,
        priority: _selectedPriority,
        completed: false,
      );

      Navigator.pop(context, newTask);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content:
                const Text('Por favor, insira uma descrição para a tarefa.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, _saveTask);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
