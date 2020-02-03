import 'package:flutter/material.dart';

import 'models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> taskList = [];

  addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }

  toggleTask(int index) {
    taskList != null ? taskList[index].toggleComplete() : null;
    notifyListeners();
  }

  deleteTask(Task task) {
    taskList.remove(task);
    notifyListeners();
  }
}
