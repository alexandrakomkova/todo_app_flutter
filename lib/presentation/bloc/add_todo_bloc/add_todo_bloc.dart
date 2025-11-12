import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';

import '../../../domain/model/todo.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoBlocEvent, AddTodoState> {
  final TodoRepositoryImpl _todoRepositoryImpl;

  AddTodoBloc({
    required TodoRepositoryImpl todoRepositoryImpl,
    required Todo? initialTodo,
  }) : _todoRepositoryImpl = todoRepositoryImpl,
        super(
        AddTodoState(
          initialTodo: initialTodo,
          title: initialTodo?.title ?? '',
          description: initialTodo?.description ?? '',
        ),
  ) {
    on<OnTodoTitleChanged>(_onTodoTitleChanged);
    on<OnTodoDescriptionChanged>(_onTodoDescriptionChanged);
    on<OnTodoSave>(_onTodoSave);
  }

  void _onTodoTitleChanged(
      OnTodoTitleChanged event,
      Emitter<AddTodoState> emit,
  ) {
    print(event.title);
    emit(state.copyWith(title: event.title));
  }

  void _onTodoDescriptionChanged(
      OnTodoDescriptionChanged event,
      Emitter<AddTodoState> emit,
      ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onTodoSave(
      OnTodoSave event,
      Emitter<AddTodoState> emit
  ) async {
    emit(state.copyWith(status: AddTodoStatus.loading));

    final todo = (state.initialTodo ?? Todo(
        title: '',
        description: '',
        timestampInMillisecondsFromEpoch: DateTime.now().millisecondsSinceEpoch
    )).copyWith(
      title: state.title,
      description: state.description,
      timestampInMillisecondsFromEpoch: DateTime.now().millisecondsSinceEpoch
    );

    try {
      await _todoRepositoryImpl.addTodo(todo);
      emit(state.copyWith(status: AddTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTodoStatus.failure));
    }
  }
}
