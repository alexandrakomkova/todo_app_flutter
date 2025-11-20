part of 'app_bar_bloc.dart';

sealed class AppBarEvent {
  const AppBarEvent();
}

final class AppBarTodoStatsRequested extends AppBarEvent {
  const AppBarTodoStatsRequested();
}
