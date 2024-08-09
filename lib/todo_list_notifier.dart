import 'package:flutter/cupertino.dart';
import 'package:tarefas_do_chagas/todo.dart';
import 'package:tarefas_do_chagas/todo_filter.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super(_initialValue);

  static final List<Todo> _initialValue = [
    Todo.create('Task 1'),
    Todo.create('Task 2'),
    Todo.create('Task 3'),
    Todo.create('Task 4'),
    Todo.create('Task 5'),
  ];

  final _allTodosNotifier = ValueNotifier<List<Todo>>(_initialValue);
  TodoFilter _currentFilter = TodoFilter.all;

  List<Todo> get _todos => _allTodosNotifier.value;

  void init() {
    _allTodosNotifier.addListener(() => _updateTodoList());
  }

  void add(Todo todo) {
    _allTodosNotifier.value = [...value, todo];
  }

  void update(String id, String task) {
    _allTodosNotifier.value = [
      for (final todo in value)
        if (todo.id != id) todo else todo.copyWith(task: task)
    ];
  }

  void toogle(String id) {
    _allTodosNotifier.value = [
      for (final todo in value)
        if (todo.id != id) todo else todo.copyWith(completed: !todo.completed)
    ];
  }

  void remove(String id) {
    _allTodosNotifier.value = value.where((todo) => todo.id != id).toList();
  }

  void changeFilter(TodoFilter filter) {
    _currentFilter = filter;
    _updateTodoList();
  }

  void _updateTodoList() {
    value = _mapFilterToTodoList();
  }

  List<Todo> _mapFilterToTodoList() => switch (_currentFilter) {
        TodoFilter.incomplete =>
          _todos.where((todo) => !todo.completed).toList(),
        TodoFilter.completed => _todos.where((todo) => todo.completed).toList(),
        _ => _todos
      };
}
