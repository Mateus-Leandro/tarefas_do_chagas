import 'package:flutter/material.dart';
import 'package:tarefas_do_chagas/service_locator.dart';
import 'package:tarefas_do_chagas/todo.dart';
import 'package:tarefas_do_chagas/todo_list_controller.dart';

class NewTodoWidget extends StatefulWidget {
  const NewTodoWidget({
    super.key,
  });

  @override
  State<NewTodoWidget> createState() => _NewTodoWidgetState();
}

class _NewTodoWidgetState extends State<NewTodoWidget> {
  late TextEditingController todoController = TextEditingController();
  final controller = getIt<TodoListController>();
  final todoNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Form(
        key: formKey,
        child: TextFormField(
          focusNode: todoNode,
          controller: todoController,
          decoration: InputDecoration.collapsed(
            hintText: 'Escreva uma nova tarefa...',
          ),
          validator: (valor) {
            if (valor == null || valor.isEmpty) {
              return 'Não pode ser vazio.';
            }
            return null;
          },
          onFieldSubmitted: (_) => onSubmmitted(),
        ),
      ),
      trailing: TextButton(
        child: const Text('Salvar'),
        onPressed: onSubmmitted,
      ),
    );
  }

  void onSubmmitted() {
    if (!formKey.currentState!.validate()) {
      todoNode.requestFocus();
    } else {
      controller.add(todoController.text);
      formKey.currentState!.reset();
      todoNode.unfocus();
    }
  }
}
