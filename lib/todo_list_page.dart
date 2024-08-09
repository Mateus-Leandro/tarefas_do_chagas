import 'package:flutter/material.dart';
import 'package:tarefas_do_chagas/new_todo_widget.dart';
import 'package:tarefas_do_chagas/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({
    super.key,
  });

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('To Do App'),
        ),
        body: ListView(
          children: [
            const NewTodoWidget(),
            TodoListWidget(),
          ],
        ));
  }
}
