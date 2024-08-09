import 'package:flutter/material.dart';
import 'package:tarefas_do_chagas/service_locator.dart';
import 'package:tarefas_do_chagas/todo_filter.dart';
import 'package:tarefas_do_chagas/todo_item_widget.dart';
import 'package:tarefas_do_chagas/todo_list_controller.dart';

class TodoListWidget extends StatelessWidget {
  TodoListWidget({super.key});

  final controller = getIt<TodoListController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.todoListNotifier,
      builder: (context, todoList, child) {
        var isFilterAll = controller.filterNotifier.value == TodoFilter.all;
        if (todoList.isEmpty && !isFilterAll) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: const Text('Vazio'),
            ),
          );
        }
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList[index];
            return TodoItemWidget(
                key: ValueKey(todo.id), todo: todoList[index]);
          },
        );
      },
    );
  }
}
