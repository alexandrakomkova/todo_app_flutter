import 'package:hive_ce/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Box<Todo> _todoBox;
  final BehaviorSubject<List<Todo>> _todoStreamController;

  TodoRepositoryImpl(this._todoBox): _todoStreamController = BehaviorSubject<List<Todo>>.seeded(
    _todoBox.values.toList(),
  );

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();


  @override
  Future<void> addTodo(Todo todo) async {
    final todos = [..._todoStreamController.value, todo];
    _todoStreamController.add(todos);

    // key can not be more than 32-bit so convert to string
    await _todoBox.put(todo.creationTimestamp.toString(), todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    final todos = [..._todoStreamController.value];
    final itemRemoved =  todos.remove(todo);
    if (!itemRemoved) throw TodoNotFoundException();

    _todoStreamController.add(todos);

    await _todoBox.delete(todo.creationTimestamp.toString());
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.creationTimestamp == todo.creationTimestamp);
    if (todoIndex == -1) throw TodoNotFoundException();

    todos[todoIndex] = todo;
    _todoStreamController.add(todos);

    await _todoBox.put(todo.creationTimestamp.toString(), todo);
  }

  @override
  Future<void> close() {
    return _todoStreamController.close();
  }

}