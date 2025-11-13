part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

final class TodoState extends Equatable {
  final List<Todo> todoList;
  final TodoStatus status;
  final TodoFilter filter;
  final TodoOrderType orderType;

  const TodoState({
    this.todoList = const [],
    this.status = TodoStatus.initial,
    this.filter = TodoFilter.all,
    this.orderType = TodoOrderType.ascending,
  });

  Iterable<Todo> get filteredTodos => filter.applyAll(todoList);
  Iterable<Todo> get orderedTodos => orderType.sort(todoList.toList());
  Iterable<Todo> get filteredAndOrderedTodos => sortTodos(filteredTodos.toList(), orderType);

    TodoState copyWith({
      List<Todo>? todoList,
      TodoStatus? status,
      TodoFilter? filter,
      TodoOrderType? orderType,
    }) {
      return TodoState(
        status: status ?? this.status,
        todoList:  todoList ?? this.todoList,
        filter: filter ?? this.filter,
        orderType: orderType ?? this.orderType,
      );
    }

    @override
    List<Object> get props => [
      status,
      todoList,
      filter,
      orderType,
    ];
  }

