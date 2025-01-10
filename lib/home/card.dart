import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'details.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final bool completed;
  final int taskIndex;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.completed,
    required this.taskIndex,
  });

  @override
  TaskCardState createState() => TaskCardState();
}

class TaskCardState extends State<TaskCard> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.completed;
  }

  void _updateTaskInBox(bool newStatus) async {
    var box = await Hive.openBox('todos');

    await box.putAt(widget.taskIndex, {
      'title': widget.title,
      'description': widget.description,
      'completed': newStatus,
    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(
              title: widget.title,
              description: widget.description,
              taskIndex: widget.taskIndex,
              completed: _isChecked,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  decoration: _isChecked ? TextDecoration.lineThrough : null,
                  color: _isChecked ? Colors.grey : Colors.white,
                ),
              ),
              Checkbox(
                value: _isChecked,
                activeColor: Colors.deepPurple,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });

                  _updateTaskInBox(_isChecked);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
