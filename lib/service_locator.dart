import 'package:get_it/get_it.dart';
import 'package:tarefas_do_chagas/hive_storage.dart';
import 'package:tarefas_do_chagas/storage_service.dart';
import 'package:tarefas_do_chagas/todo_list_controller.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<TodoListController>(() => TodoListController());
  getIt.registerLazySingleton<StorageService>(() => HiveStorage());
}
