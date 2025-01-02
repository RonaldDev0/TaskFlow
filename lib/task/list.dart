import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'card.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  TaskListWidgetState createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskList> {
  late Box todosBox;

  @override
  void initState() {
    super.initState();
    todosBox = Hive.box('todos');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todosBox.listenable(),
      builder: (context, Box box, _) {

        if (box.isEmpty) {
          return const Center(
            child: Text(
              'No tasks available. Add a task!',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {

            final task = Map<String, dynamic>.from(box.getAt(index));

            return TaskCard(
              title: task['title'],
              isChecked: task['completed'],
              onChanged: (bool? value) {
                setState(() {
                  task['isChecked'] = value;
                  box.putAt(index, task);
                });
              },
            );
          },
        );
      },
    );
  }
}
