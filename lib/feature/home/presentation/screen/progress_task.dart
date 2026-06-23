import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/task_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/list_view_custom_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  static const String name = "/progress_task";

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
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
            final tasks = taskProvider.progressTasks;
            if (tasks.isEmpty) {
              return const Center(child: Text("No progress tasks."));
            }
            return ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListViewCustomCard(
                  color: Colors.orange,
                  title: task.title,
                  description: task.description,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
