import 'package:injectable/injectable.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';

import '../model/todo.dart';

@lazySingleton
class AddTodoUseCase {
  final TodoRepositoryImpl _repository;

  AddTodoUseCase(this._repository);

  Future<void> call(Todo todo) async {
    await _repository.addTodo(todo);
  }
}