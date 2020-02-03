class Task {
  String task;
  bool isCompleted;

  Task({this.task, this.isCompleted = false});

  toggleComplete() {
    isCompleted = !isCompleted;
  }
}
