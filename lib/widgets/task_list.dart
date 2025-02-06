import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;

    return tasks.isEmpty
        ? Center(child: Text('No tasks yet!'))
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (ctx, index) {
              final task = tasks[index];
              return Card(
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .toggleTaskStatus(task.id);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue[500]
                        ),
                        onPressed: () {
                          _editTask(context, task.id, task.title);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Provider.of<TaskProvider>(context, listen: false)
                              .deleteTask(task.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  void _editTask(BuildContext context, String id, String currentTitle) {
    TextEditingController _controller =
        TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .editTask(id, _controller.text);
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
