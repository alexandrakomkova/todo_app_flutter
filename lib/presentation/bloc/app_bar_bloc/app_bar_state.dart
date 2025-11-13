part of 'app_bar_bloc.dart';

enum AppBarStatus { initial, loading, success, failure }

final class AppBarState extends Equatable {
  final AppBarStatus status;
  final int completedTodoCount;
  final int unCompletedTodoCount;

  const AppBarState({
    this.status = AppBarStatus.initial,
    this.completedTodoCount = 0,
    this.unCompletedTodoCount = 0,
  });

  AppBarState copyWith({
    AppBarStatus? status,
    int? completedTodoCount,
    int? unCompletedTodoCount,
    TodoFilter? filter,
  }) {
    return AppBarState(
      status: status ?? this.status,
      completedTodoCount: completedTodoCount ?? this.completedTodoCount,
      unCompletedTodoCount: unCompletedTodoCount ?? this.unCompletedTodoCount,
    );
  }

  @override
  List<Object> get props => [
    status,
    completedTodoCount,
    unCompletedTodoCount,
  ];
}

