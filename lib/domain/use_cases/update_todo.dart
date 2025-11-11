import 'package:injectable/injectable.dart';

import '../../data/repository/todo_repository_impl.dart';
import '../model/todo.dart';

@lazySingleton
class UpdateTodoUseCase {
  final TodoRepositoryImpl _repository;

  UpdateTodoUseCase(this._repository);

  Future<void> call(Todo todo) async {
    await _repository.updateTodo(todo);
  }
}