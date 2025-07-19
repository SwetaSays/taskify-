import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'task_tile.dart';

class HomePage extends StatelessWidget {
  final TaskController controller = Get.find();
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Taskify")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                hintText: "Enter a task",
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (inputController.text.trim().isNotEmpty) {
                      controller.addTask(inputController.text.trim());
                      inputController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['All', 'Active', 'Completed'].map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(e),
                  selected: controller.filter.value == e,
                  onSelected: (_) => controller.setFilter(e),
                ),
              );
            }).toList(),
          )),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredTasks.length,
              itemBuilder: (context, index) {
                return TaskTile(index: controller.tasks.indexOf(controller.filteredTasks[index]));
              },
            )),
          )
        ],
      ),
    );
  }
}
