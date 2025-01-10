import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'card.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  TaskListWidgetState createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskList> {
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('todos');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box box, _) {
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            var task = box.getAt(index);
            return TaskCard(
              title: task['title'],
              description: task['description'],
              completed: task['completed'],
              taskIndex: index,
            );
          },
        );
      },
    );
  }
}
