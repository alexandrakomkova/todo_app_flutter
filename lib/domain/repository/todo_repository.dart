import '../model/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);

  // to close any used resources
  Future<void> close();
}