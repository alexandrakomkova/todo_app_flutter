import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/todo_repository_impl.dart';
import '../../../domain/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepositoryImpl _todoRepositoryImpl;
  TodoBloc({
    required TodoRepositoryImpl todoRepositoryImpl,
  }):_todoRepositoryImpl = todoRepositoryImpl,
        super(const TodoState()) {
    on<AddTodoEvent>(_addTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<GetTodoListEvent>(_getTodoList);
  }

  Future<void> _addTodo(
    AddTodoEvent event,
    Emitter<TodoState> emit
  ) async {
    try {
      await _todoRepositoryImpl.addTodo(event.todo);
      emit(state.copyWith(status: () => TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: () => TodoStatus.failure));
    }

  }

  Future<void> _deleteTodo(
      DeleteTodoEvent event,
      Emitter<TodoState> emit
  ) async {
    try {
      await _todoRepositoryImpl.deleteTodo(event.todo);
      emit(state.copyWith(status: () => TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: () => TodoStatus.failure));
    }
  }

  Future<void> _updateTodo(
      UpdateTodoEvent event,
      Emitter<TodoState> emit
  ) async {
    try {
      await _todoRepositoryImpl.updateTodo(event.todo);
      emit(state.copyWith(status: () => TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: () => TodoStatus.failure));
    }
  }

  Future<void> _getTodoList(
      GetTodoListEvent event,
      Emitter<TodoState> emit
  ) async {
    emit(state.copyWith(status: () => TodoStatus.loading));

    await emit.forEach<List<Todo>>(
      _todoRepositoryImpl.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodoStatus.success,
        todoList: () => todos,
      ),
      onError: (_, _) => state.copyWith(
        status: () => TodoStatus.failure,
      ),
    );

  }
}
