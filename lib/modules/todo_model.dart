class TodoModel {
  String? title;
  bool isDone;

  TodoModel({this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}