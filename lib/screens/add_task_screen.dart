import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();

  void _submitData() {
    final enteredTask = _taskController.text;

    if (enteredTask.isEmpty) return;

    Provider.of<TaskProvider>(context, listen: false).addTask(enteredTask);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Task'),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
