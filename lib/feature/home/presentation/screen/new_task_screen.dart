import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/feature/home/presentation/screen/add_new_task_screen.dart';
import '../../provider/task_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/list_view_custom_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static const String name = "/new_task";

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, _) {
            if (taskProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomCard(
                        count: taskProvider.newTasks.length.toString(),
                        child: "New Task",
                      ),
                      CustomCard(
                        count: taskProvider.completedTasks.length.toString(),
                        child: "Completed",
                      ),
                      CustomCard(
                        count: taskProvider.canceledTasks.length.toString(),
                        child: "Canceled",
                      ),
                      CustomCard(
                        count: taskProvider.progressTasks.length.toString(),
                        child: "Progress",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: taskProvider.newTasks.isEmpty
                      ? const Center(child: Text("No new tasks found."))
                      : ListView.separated(
                          itemCount: taskProvider.newTasks.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final task = taskProvider.newTasks[index];
                            return GestureDetector(
                              onTap: () => _showActionDialog(task),
                              child: ListViewCustomCard(
                                color: Colors.blue,
                                title: task.title,
                                description: task.description,
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _onTapFloatingActionButton,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showActionDialog(task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Task Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _statusButton("Completed", Colors.green, task.id),
              _statusButton("Canceled", Colors.red, task.id),
              _statusButton("Progress", Colors.orange, task.id),
              const Divider(),
              TextButton(
                onPressed: () {
                  context.read<TaskProvider>().deleteTask(task.id);
                  Navigator.pop(context);
                },
                child: const Text("Delete Task", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusButton(String status, Color color, String taskId) {
    return TextButton(
      onPressed: () {
        context.read<TaskProvider>().updateTaskStatus(taskId, status);
        Navigator.pop(context);
      },
      child: Text(status, style: TextStyle(color: color)),
    );
  }

  void _onTapFloatingActionButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
