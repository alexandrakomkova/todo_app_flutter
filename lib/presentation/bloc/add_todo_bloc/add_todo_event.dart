part of 'add_todo_bloc.dart';

sealed class AddTodoBlocEvent extends Equatable {
  const AddTodoBlocEvent();
  @override
  List<Object> get props => [];
}

final class OnTodoTitleChanged extends AddTodoBlocEvent {
  final String title;

  const OnTodoTitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

final class OnTodoDescriptionChanged extends AddTodoBlocEvent {
  final String description;

  const OnTodoDescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

final class OnTodoSave extends AddTodoBlocEvent {
  const OnTodoSave();
}

