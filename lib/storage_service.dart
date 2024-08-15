import 'package:tarefas_do_chagas/todo.dart';

abstract class StorageService {
  Future<List<Todo>> getTodos();
  Future<void> saveTodos(List<Todo> todos);
}
