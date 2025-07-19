import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class TaskTile extends StatelessWidget {
  final int index;
  final TaskController controller = Get.find();
  TaskTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final task = controller.tasks[index];
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (_) => controller.toggleStatus(index),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              final editController = TextEditingController(text: task.title);
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Edit Task"),
                  content: TextField(controller: editController),
                  actions: [
                    TextButton(
                      onPressed: () {
                        controller.updateTask(index, editController.text);
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    )
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => controller.deleteTask(index),
          ),
        ],
      ),
    );
  }
}
