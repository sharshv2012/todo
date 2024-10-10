import 'package:flutter/material.dart';
import 'package:todo/modules/todo_model.dart';
import 'package:todo/modules/todo_repo.dart';

class TodoMainPage extends StatefulWidget {
  const TodoMainPage({super.key});

  @override
  State<TodoMainPage> createState() => _TodoMainPageState();
}

class _TodoMainPageState extends State<TodoMainPage> {
  final List<TodoModel> todos = TodoRepo.todos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todofy', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.cyanAccent,
        ),
        backgroundColor: Colors.cyanAccent.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add Todo'),
                      content: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your todo',
                        ),
                        onChanged: (value) {
                          setState(() {
                            TodoRepo.todo = value;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (TodoRepo.todo.isEmpty || TodoRepo.todo == '') {
                              showDialog(context: context, builder: 
                              (context) {
                                return AlertDialog(
                                  title: const Text('Todo cannot be empty'),
                                  content: const Text('Please enter a valid todo'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              });
                              return;
                            }
                            setState(() {
                              todos.add(TodoModel(title: TodoRepo.todo));
                              TodoRepo.todo = '';
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  });
            });
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (final todo in todos) 
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: todo.isDone
                            ? [Colors.cyanAccent, Colors.blueAccent]
                            : [
                                Colors.pinkAccent.withOpacity(0.8),
                                Colors.white
                              ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(todo.title ?? 'No Title'),
                        ),
                        IconButton(
                            onPressed: () {
                              if (!todo.isDone) {
                                setState(() {
                                  todo.toggleDone();
                                });
                              }
                            },
                            icon: Icon(todo.isDone
                                ? Icons.done_all_outlined
                                : Icons.pending_actions)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                todos.remove(todo);
                              });
                            },
                            icon: const Icon(Icons.delete)),

                        IconButton(onPressed: (){
                          showDialog(context: context, builder: 
                          (context) {
                            return AlertDialog(
                              title: const Text('Edit Todo'),
                              content: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter your todo',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    TodoRepo.todo = value;
                                  });
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (TodoRepo.todo.isEmpty || TodoRepo.todo == '') {
                                      showDialog(context: context, builder: 
                                      (context) {
                                        return AlertDialog(
                                          title: const Text('Todo cannot be empty'),
                                          content: const Text('Please enter a valid todo'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      });
                                      return;
                                    }
                                    setState(() {
                                      TodoRepo.editTodo(TodoRepo.todo, todos.indexOf(todo));
                                      TodoRepo.todo = '';
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Edit'),
                                ),
                              ],
                            );
                          });
                        }, icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}
