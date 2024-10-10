import 'package:todo/modules/todo_model.dart';

class TodoRepo {
  static List<TodoModel> todos = [
    TodoModel(title: 'Learn Flutter', isDone: true,),
    TodoModel(title: 'Learn Dart', isDone: false),
    TodoModel(title: 'Learn State Management', isDone: false),
    TodoModel(title: 'Learn Firebase', isDone: false),
    TodoModel(title: 'Learn GraphQL', isDone: false),
    TodoModel(title: 'Learn CI/CD', isDone: false),
  ];

  static String todo = '';
}