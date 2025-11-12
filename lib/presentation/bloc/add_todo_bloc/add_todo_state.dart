part of 'add_todo_bloc.dart';

enum AddTodoStatus { initial, loading, success, failure }

extension AddTodoStatusX on AddTodoStatus {
  bool get isLoadingOrSuccess => [
    AddTodoStatus.loading,
    AddTodoStatus.success,
  ].contains(this);
}

final class AddTodoState extends Equatable {
  final String title;
  final String description;
  final AddTodoStatus status;
  // final Todo? initialTodo;

 // bool get isNewTodo => initialTodo == null;

  const AddTodoState({
    this.title = '',
    this.description = '',
    this.status = AddTodoStatus.initial,
    //this.initialTodo
  });

  AddTodoState copyWith({
    AddTodoStatus? status,
    Todo? initialTodo,
    String? title,
    String? description,
  }) {
    return AddTodoState(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      //initialTodo: initialTodo ?? this.initialTodo,
    );
  }

  @override
  List<Object?> get props => [status, title, description];

}
