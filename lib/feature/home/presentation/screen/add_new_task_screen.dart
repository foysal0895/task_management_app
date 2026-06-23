import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/app/validators/app_fields_validators.dart';
import 'package:taskmanager/feature/controller/main_nav_holder.dart';
import '../../../auth/presentation/widgets/custom_filled_button.dart';
import '../../provider/task_provider.dart';
import '../model/add_task_model.dart';
import '../widgets/custom_app_bar.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = "/add_new_task";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTEController,
                  decoration: const InputDecoration(
                    hintText: "Task Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      AppFieldsValidators.validateInput(value, "Enter a title"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Task Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => AppFieldsValidators.validateInput(
                    value,
                    "Enter a description",
                  ),
                ),
                const SizedBox(height: 12),
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, _) {
                    return taskProvider.isLoading
                        ? const CircularProgressIndicator()
                        : CustomFilledButton(onPressed: _onTapFilledButton);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapFilledButton() async {
    if (!_formKey.currentState!.validate()) return;

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    final newTask = TaskModel(
      id: '',
      title: _titleTEController.text.trim(),
      description: _descriptionTEController.text.trim(),
      status: 'New',
    );

    bool isSuccess = await taskProvider.addTask(newTask);

    if (mounted) {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Task added successfully!"),
              backgroundColor: Colors.green),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, MainNavHolder.name, (_) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Something went wrong!"),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
