part of 'todo_bloc.dart';

sealed class TodoEvent{
  const TodoEvent();
}

final class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent(this.todo);
}

final class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  const UpdateTodoEvent(this.todo);
}

final class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  const DeleteTodoEvent(this.todo);
}

final class GetTodoListEvent extends TodoEvent {
  const GetTodoListEvent();
}

final class OnCompletedChanged extends TodoEvent {
  final Todo todo;
  final bool isCompleted;

  const OnCompletedChanged({
    required this.todo,
    required this.isCompleted,
  });
}

final class OnFilterChanged extends TodoEvent {
  final TodoFilter filter;

  const OnFilterChanged(this.filter);
}

final class OnOrderTypeChanged extends TodoEvent {
  final TodoOrderType orderType;

  const OnOrderTypeChanged(this.orderType);
}
