import '../todo.dart';

enum TodoOrderType { descending, ascending }

extension OrderTypeX on TodoOrderType {
  Iterable<Todo> sort(List<Todo> todos) {
    return sortTodos(todos, this);
  }
}

Iterable<Todo> sortTodos(List<Todo> todos, TodoOrderType orderType) {
  switch(orderType) {
    case TodoOrderType.descending:
      todos.sort((a,b) => a.timestampInMillisecondsFromEpoch.compareTo(b.timestampInMillisecondsFromEpoch));
    case TodoOrderType.ascending:
      todos.sort((b,a) => a.timestampInMillisecondsFromEpoch.compareTo(b.timestampInMillisecondsFromEpoch));
  }

  return todos;
}


