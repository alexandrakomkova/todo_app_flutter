import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/model/todo_filter/todo_filter.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

part 'app_bar_event.dart';
part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final TodoRepository _todoRepository;

  AppBarBloc({
    required TodoRepository todoRepository
  }) : _todoRepository = todoRepository, super(const AppBarState()) {
    on<AppBarTodoStatsRequested>(_getTodoStats);
  }

  factory AppBarBloc.requestStats({required TodoRepository todoRepository}) =>
    AppBarBloc(todoRepository: todoRepository)..add(AppBarTodoStatsRequested());

  Future<void> _getTodoStats(
      AppBarTodoStatsRequested event,
      Emitter<AppBarState> emit,
  ) async {
    emit(state.copyWith(status: AppBarStatus.loading));
    
    await emit.forEach<List<Todo>>(
      _todoRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: AppBarStatus.success,
        completedTodoCount: todos.where((todo) => todo.isCompleted).length,
        unCompletedTodoCount: todos.where((todo) => !todo.isCompleted).length,
      ),
      onError: (_, _) => state.copyWith(status:  AppBarStatus.failure)
    );
  }
}


