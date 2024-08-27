import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tarefas_do_chagas/service_locator.dart';
import 'package:tarefas_do_chagas/todo.dart';
import 'package:tarefas_do_chagas/todo_list_controller.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late TextEditingController todoController;
  final controller = getIt<TodoListController>();
  Timer? debouncer;

  @override
  void initState() {
    todoController = TextEditingController(text: widget.todo.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        controller: todoController,
        decoration: InputDecoration.collapsed(
          hintText: 'Escreva sua tarefa...',
        ),
        onChanged: onChanged,
      ),
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: onToggled,
      ),
      trailing: IconButton(
        onPressed: onDeleted,
        visualDensity: VisualDensity.compact,
        icon: const Icon(Icons.close_rounded),
      ),
    );
  }

  void onChanged(String task) {
    debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 500), () {
      controller.update(widget.todo.id, task);
    });
  }

  void onToggled(_) {
    controller.toggle(widget.todo.id);
  }

  void onDeleted() {
    controller.remove(widget.todo.id);
  }
}
