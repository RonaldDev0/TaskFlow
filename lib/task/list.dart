import 'package:flutter/material.dart';
import 'card.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  TaskListWidgetState createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskList> {
  // Sample task data with initial checkbox state
  final List<Map<String, dynamic>> tasks = [
    {'title': 'Task 1', 'isChecked': false},
    {'title': 'Task 2', 'isChecked': false},
    {'title': 'Task 3', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          title: task['title'],
          isChecked: task['isChecked'],
          onChanged: (bool? value) {
            setState(() {
              task['isChecked'] = value;
            });
          },
        );
      },
    );
  }
}
