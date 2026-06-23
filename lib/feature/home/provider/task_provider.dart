import 'package:flutter/material.dart';
import '../fireStoreServices/fire_store_services.dart';
import '../presentation/model/add_task_model.dart';


class TaskProvider extends ChangeNotifier {
  final FireStoreServices _service = FireStoreServices();

  List<TaskModel> _allTasks = [];
  
  List<TaskModel> get newTasks => _allTasks.where((t) => t.status == 'New').toList();
  List<TaskModel> get completedTasks => _allTasks.where((t) => t.status == 'Completed').toList();
  List<TaskModel> get canceledTasks => _allTasks.where((t) => t.status == 'Canceled').toList();
  List<TaskModel> get progressTasks => _allTasks.where((t) => t.status == 'Progress').toList();

  // For compatibility with existing code that uses .tasks
  List<TaskModel> get tasks => newTasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allTasks = await _service.getTasks();
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addTask(TaskModel task) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.addTask(task);
      await getTasks(); // Refresh list
      return true;
    } catch (e) {
      debugPrint("Error adding task: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTaskStatus(String taskId, String newStatus) async {
    try {
      await _service.updateTaskStatus(taskId, newStatus);
      await getTasks(); // Refresh list
      return true;
    } catch (e) {
      debugPrint("Error updating task status: $e");
      return false;
    }
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      await _service.deleteTask(taskId);
      await getTasks(); // Refresh list
      return true;
    } catch (e) {
      debugPrint("Error deleting task: $e");
      return false;
    }
  }
}
