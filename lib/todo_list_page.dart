import 'package:flutter/material.dart';
import 'package:tarefas_do_chagas/new_todo_widget.dart';
import 'package:tarefas_do_chagas/service_locator.dart';
import 'package:tarefas_do_chagas/todo_filter.dart';
import 'package:tarefas_do_chagas/todo_list_controller.dart';
import 'package:tarefas_do_chagas/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({
    super.key,
  });

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final controller = getIt<TodoListController>();
  static const List<Tab> tabs = [
    Tab(text: 'Todas'),
    Tab(text: 'a fazer'),
    Tab(text: 'Concluídas')
  ];

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('To Do App'),
            bottom: TabBar(
              tabs: tabs,
              onTap: (index) {
                controller.changeFilter(TodoFilter.values[index]);
              },
            ),
          ),
          body: ListView(
            children: [
              const NewTodoWidget(),
              TodoListWidget(),
            ],
          )),
    );
  }
}
