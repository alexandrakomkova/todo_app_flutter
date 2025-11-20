import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/todo.dart';
import '../../../domain/repository/todo_repository.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoBlocEvent, AddTodoState> {
  final TodoRepository _todoRepository;

  AddTodoBloc({
    required TodoRepository todoRepository,
    required Todo? initialTodo,
  }) : _todoRepository = todoRepository,
        super(
        AddTodoState(
          initialTodo: initialTodo,
          title:  initialTodo?.title ?? '',
          description:  initialTodo?.description ?? '',
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
    );

    try {
      state.isNewTodo ? await _todoRepository.addTodo(todo) : await _todoRepository.updateTodo(todo);
      emit(state.copyWith(status: AddTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTodoStatus.failure));
    }
  }
}
