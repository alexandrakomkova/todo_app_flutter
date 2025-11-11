part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

final class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  const UpdateTodoEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

final class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  const DeleteTodoEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

final class GetTodoListEvent extends TodoEvent {
  const GetTodoListEvent();
}
