part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

final class TodoState extends Equatable {
  final List<Todo> todoList;
  final TodoStatus status;

  const TodoState({
    this.todoList = const [],
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    List<Todo>? todoList,
    TodoStatus? status,
  }) {
    return TodoState(
      status: status ?? this.status,
      todoList:  todoList ?? this.todoList,
    );
  }

  @override
  List<Object> get props => [status, todoList];
}

