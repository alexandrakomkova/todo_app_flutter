part of 'add_todo_bloc.dart';

enum AddTodoStatus {
  initial, loading, success, failure;

  bool get isLoadingOrSuccess => [
    AddTodoStatus.loading,
    AddTodoStatus.success,
  ].contains(this);
}

final class AddTodoState extends Equatable {
  final String id;
  final String title;
  final String description;
  final AddTodoStatus status;

  bool get isNewTodo => id.isEmpty;

  const AddTodoState({
    this.id = '',
    this.title = '',
    this.description = '',
    this.status = AddTodoStatus.initial,
  });

  AddTodoState copyWith({
    String? id,
    AddTodoStatus? status,
    String? title,
    String? description,
  }) {
    return AddTodoState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    status,
    title,
    description,
  ];

}
