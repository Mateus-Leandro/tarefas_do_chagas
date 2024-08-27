import 'package:flutter/cupertino.dart';
import 'package:tarefas_do_chagas/service_locator.dart';
import 'package:tarefas_do_chagas/storage_service.dart';
import 'package:tarefas_do_chagas/todo.dart';
import 'package:tarefas_do_chagas/todo_filter.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  final _allTodosNotifier = ValueNotifier<List<Todo>>([]);
  TodoFilter _currentFilter = TodoFilter.all;
  final _storageService = getIt<StorageService>();

  List<Todo> get _todos => _allTodosNotifier.value;

  void init() async {
    _allTodosNotifier.value = await _storageService.getTodos();
    _updateTodoList();

    _allTodosNotifier.addListener(() {
      _updateTodoList();
      _saveTodoListToDB();
    });
  }

  void add(Todo todo) {
    _allTodosNotifier.value = [..._todos, todo];
  }

  void update(String id, String task) {
    _allTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(task: task)
    ];
  }

  void toogle(String id) {
    _allTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(completed: !todo.completed)
    ];
  }

  void remove(String id) {
    _allTodosNotifier.value = _todos.where((todo) => todo.id != id).toList();
  }

  void reorder(List<Todo> todos) {
    _allTodosNotifier.value = todos;
  }

  void changeFilter(TodoFilter filter) {
    _currentFilter = filter;
    _updateTodoList();
  }

  void _updateTodoList() {
    value = _mapFilterToTodoList();
  }

  void _saveTodoListToDB() {
    _storageService.saveTodos(
      _todos.where((todo) => todo.task.isNotEmpty).toList(),
    );
  }

  List<Todo> _mapFilterToTodoList() => switch (_currentFilter) {
        TodoFilter.incomplete =>
          _todos.where((todo) => !todo.completed).toList(),
        TodoFilter.completed => _todos.where((todo) => todo.completed).toList(),
        _ => _todos
      };
}
