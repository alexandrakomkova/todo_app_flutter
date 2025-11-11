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
    List<Todo> Function()? todoList,
    TodoStatus Function()? status,
  }) {
    return TodoState(
      status: status != null ? status() : this.status,
      todoList:  todoList != null ? todoList() : this.todoList,
    );
  }

  @override
  List<Object> get props => [status, todoList];
}

