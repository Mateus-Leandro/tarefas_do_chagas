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
    Tab(text: 'all'),
    Tab(text: 'incomplete'),
    Tab(text: 'completed')
  ];

  String selectedSegment = tabs[0].text!;

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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: SegmentedButton(
                // showSelectedIcon: true,
                segments: <ButtonSegment<String>>[
                  ButtonSegment<String>(
                    value: tabs[0].text!,
                    label: Text('Todas'),
                  ),
                  ButtonSegment<String>(
                    value: tabs[1].text!,
                    label: Text('A fazer'),
                  ),
                  ButtonSegment<String>(
                    value: tabs[2].text!,
                    label: Text('Concluidas'),
                  )
                ],
                selected: {selectedSegment},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    selectedSegment = newSelection.first;
                    controller.changeFilter(
                      TodoFilter.values[tabs
                          .indexWhere((tab) => tab.text == selectedSegment)],
                    );
                  });
                },
              ),
            ),
          ),
          body: ListView(
            children: [
              ValueListenableBuilder(
                valueListenable: controller.filterNotifier,
                builder: (context, filter, child) {
                  if (filter == TodoFilter.completed) {
                    return const SizedBox.shrink();
                  }
                  return const NewTodoWidget();
                },
              ),
              TodoListWidget(),
            ],
          )),
    );
  }
}
