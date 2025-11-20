part of 'add_todo_bloc.dart';

sealed class AddTodoBlocEvent {
  const AddTodoBlocEvent();
}

final class OnTodoTitleChanged extends AddTodoBlocEvent {
  final String title;

  const OnTodoTitleChanged(this.title);
}

final class OnTodoDescriptionChanged extends AddTodoBlocEvent {
  final String description;

  const OnTodoDescriptionChanged(this.description);
}

final class OnTodoSave extends AddTodoBlocEvent {
  const OnTodoSave();
}

