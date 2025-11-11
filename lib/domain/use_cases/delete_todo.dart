import 'package:injectable/injectable.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';

import '../model/todo.dart';

@lazySingleton
class DeleteTodoUseCase {
  final TodoRepositoryImpl _repository;

  DeleteTodoUseCase(this._repository);

  Future<void> call(Todo todo) async {
    await _repository.deleteTodo(todo);
  }
}