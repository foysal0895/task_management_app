import 'package:cloud_firestore/cloud_firestore.dart';

import '../presentation/model/add_task_model.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(TaskModel addTaskModel) async {
    await _firestore.collection('tasks').add(addTaskModel.toMap());
  }

  Future<List<TaskModel>> getTasks() async {
    QuerySnapshot snapshot = await _firestore.collection('tasks').get();

    return snapshot.docs.map((doc) {
      return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'status': newStatus,
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
