import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/task_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/list_view_custom_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  static const String name = "/canceled_task";

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
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
            final tasks = taskProvider.canceledTasks;
            if (tasks.isEmpty) {
              return const Center(child: Text("No canceled tasks."));
            }
            return ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListViewCustomCard(
                  color: Colors.red,
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
