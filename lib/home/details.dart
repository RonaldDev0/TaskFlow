// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    super.key,
    required this.title,
    required this.completed,
    required this.description,
    required this.taskIndex,
  });

  final String title;
  final bool completed;
  final String description;
  final int taskIndex;

  @override
  TaskDetailsState createState() => TaskDetailsState();
}

class TaskDetailsState extends State<TaskDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _completed = widget.completed;
  }

  void _updateTaskInBox() async {
    var box = await Hive.openBox('todos');

    await box.putAt(widget.taskIndex, {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'completed': _completed,
    });


    Navigator.pop(context);
  }


  void _deleteTask() async {
    var box = await Hive.openBox('todos');
    await box.deleteAt(widget.taskIndex);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteTask,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              maxLines: null,
              minLines: 8,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Save button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 123, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.deepPurple
              ),
              onPressed: _updateTaskInBox,
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
