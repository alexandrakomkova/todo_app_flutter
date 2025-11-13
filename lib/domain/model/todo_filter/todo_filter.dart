import 'package:todo_app/domain/model/todo.dart';

enum TodoFilter { all, completedOnly, unCompletedOnly }

extension TodoFilterX on TodoFilter {
  bool apply(Todo todo) {
    switch(this) {
      case TodoFilter.all:
        return true;
      case TodoFilter.completedOnly:
        return todo.isCompleted;
      case TodoFilter.unCompletedOnly:
        return !todo.isCompleted;
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}