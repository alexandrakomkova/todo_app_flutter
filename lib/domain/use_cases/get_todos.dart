
import 'package:injectable/injectable.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';

import '../model/todo.dart';

@lazySingleton
class GetTodosUseCase {
  final TodoRepositoryImpl _repository;

  GetTodosUseCase(this._repository);

  Stream<List<Todo>> call() {
    return _repository.getTodos();
  }
}