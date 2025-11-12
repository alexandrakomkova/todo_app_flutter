import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final Box<Todo> _todoBox;

  TodoRepositoryImpl(this._todoBox) {
    _init();
  }

  late final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(
    const [],
  );

  void _init() {
    final todoList = _todoBox.values.toList();
    if(todoList.isEmpty) {
      _todoStreamController.add(const []);
    } else {
      _todoStreamController.add(todoList);
    }
  }

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();


  @override
  Future<void> addTodo(Todo todo) async {
    // key can not be more than 32-bit so convert to string
    await _todoBox.put(todo.timestampInMillisecondsFromEpoch.toString(), todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _todoBox.delete(todo.timestampInMillisecondsFromEpoch.toString());
  }

  @override
  Future<void> updateTodo(Todo todo) async {

    await _todoBox.put(todo.timestampInMillisecondsFromEpoch.toString(), todo);
  }

  @override
  Future<void> close() {
    return _todoStreamController.close();
  }

}