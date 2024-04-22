class TaskModel {
  String description;
  DateTime dateTime;
  bool completed;
  int priority;

  TaskModel(
      {required this.description,
      required this.dateTime,
      required this.completed,
      required this.priority});
}
