part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

final class TodoState extends Equatable {
  final List<Todo> todoList;
  final TodoStatus status;
  final TodoFilter filter;

  const TodoState({
    this.todoList = const [],
    this.status = TodoStatus.initial,
    this.filter = TodoFilter.all,
  });

  Iterable<Todo> get filteredTodos => filter.applyAll(todoList);

  TodoState copyWith({
    List<Todo>? todoList,
    TodoStatus? status,
    TodoFilter? filter,
  }) {
    return TodoState(
      status: status ?? this.status,
      todoList:  todoList ?? this.todoList,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [status, todoList, filter];
}

