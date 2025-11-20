import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/model/todo_filter/todo_filter.dart';

import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_order/todo_order.dart';
import '../../../domain/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc({
    required TodoRepository todoRepository,
  }): _todoRepository = todoRepository, super(const TodoState()) {
    on<AddTodoEvent>(_addTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<GetTodoListEvent>(_getTodoList);

    on<OnCompletedChanged>(_onCompletedChanged);
    on<OnFilterChanged>(_onFilterChanged);
    on<OnOrderTypeChanged>(_onOrderTypeChanged);
  }

  Future<void> _addTodo(
    AddTodoEvent event,
    Emitter<TodoState> emit
  ) async {
    try {
      await _todoRepository.addTodo(event.todo);

      emit(state.copyWith(status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }

  Future<void> _deleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit
  ) async {
    emit(state.copyWith(status: TodoStatus.initial));

    try {
      await _todoRepository.deleteTodo(event.todo);

      emit(state.copyWith(status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }

  Future<void> _updateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit
  ) async {
    emit(state.copyWith(status: TodoStatus.initial));

    try {
      final updatedTodoList = List<Todo>.from(state.todoList);
      await _todoRepository.updateTodo(event.todo);
      emit(state.copyWith(status: TodoStatus.success, todoList: updatedTodoList));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }

  Future<void> _getTodoList(
    GetTodoListEvent event,
    Emitter<TodoState> emit
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));

    await emit.forEach<List<Todo>>(
      _todoRepository.getTodos(),
      onData: (todos) {
        return state.copyWith(
          status: TodoStatus.success,
          todoList: todos,
        );
      },
      onError: (_, _) => state.copyWith(
        status: TodoStatus.failure,
      ),
    );
  }

  Future<void> _onCompletedChanged(
      OnCompletedChanged event,
      Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.initial));

    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);

    try {
      await _todoRepository.updateTodo(newTodo);
      emit(state.copyWith(status: TodoStatus.success));
    } catch(e) {
      emit(state.copyWith(status: TodoStatus.failure));
    }
  }

  void _onFilterChanged(
    OnFilterChanged event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  void _onOrderTypeChanged(
    OnOrderTypeChanged event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(orderType: event.orderType));
  }
}
