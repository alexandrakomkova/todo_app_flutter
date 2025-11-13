part of 'app_bar_bloc.dart';

sealed class AppBarEvent extends Equatable {
  const AppBarEvent();

  @override
  List<Object?> get props => [];
}

final class AppBarTodoStatsRequested extends AppBarEvent {
  const AppBarTodoStatsRequested();
}
