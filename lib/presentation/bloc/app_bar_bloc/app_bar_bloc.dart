import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';
import 'package:todo_app/domain/model/todo_filter.dart';

import '../../../domain/model/todo.dart';

part 'app_bar_event.dart';
part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final TodoRepositoryImpl _todoRepositoryImpl;

  AppBarBloc({
    required TodoRepositoryImpl todoRepositoryImpl
  }) : _todoRepositoryImpl = todoRepositoryImpl,
        super(const AppBarState()) {
    on<AppBarTodoStatsRequested>(_getTodoStats);
  }

  Future<void> _getTodoStats(
      AppBarTodoStatsRequested event,
      Emitter<AppBarState> emit,
  ) async {
    emit(state.copyWith(status: AppBarStatus.loading));
    
    await emit.forEach<List<Todo>>(
        _todoRepositoryImpl.getTodos(),
        onData: (todos) => state.copyWith(
          status: AppBarStatus.success,
          completedTodoCount: todos.where((todo) => todo.isCompleted).length,
          unCompletedTodoCount: todos.where((todo) => !todo.isCompleted).length,
        ),
        onError: (_, _) => state.copyWith(status:  AppBarStatus.failure)
    );
  }
}


