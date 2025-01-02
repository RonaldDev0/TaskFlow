import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  // Controllers to capture user input
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              maxLines: null,
              minLines: 8,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                // Save task
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final newTask = {
                    'title': title,
                    'description': description,
                    'completed': false,
                  };

                  final box = Hive.box('todos');
                  box.add(newTask);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Task added successfully!',
                        style: TextStyle(color: Colors.white)
                      ),
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please fill out all fields!',
                        style: TextStyle(color: Colors.white)
                      ),
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                  );
                }
              },
              child: const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
