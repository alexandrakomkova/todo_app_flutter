import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoBlocEvent, AddTodoState> {
  final TodoRepository _todoRepository;
  final Todo? _initialTodo;

  AddTodoBloc({
    required TodoRepository todoRepository,
    Todo? initialTodo,
  }) : _initialTodo = initialTodo,
       _todoRepository = todoRepository,
       super(
         AddTodoState(
           id: initialTodo?.id ?? '',
           title: initialTodo?.title ?? '',
           description:  initialTodo?.description  ?? '',
         ),
      ) {
    on<AddTodoBlocEvent>(
      (event, emit) => switch (event) {
        final OnTodoTitleChanged event => _onTodoTitleChanged(event, emit),
        final OnTodoDescriptionChanged event => _onTodoDescriptionChanged(event, emit),
        final OnTodoSave event => _onTodoSave(event, emit),
      },
      transformer: droppable()
    );
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

    final todo = Todo(
        title: state.title,
        description: state.description,
        isCompleted: _initialTodo?.isCompleted ?? false,
        creationTimestamp: _initialTodo?.creationTimestamp ?? DateTime.now().millisecondsSinceEpoch,
    );

    try {
      state.isNewTodo ? await _todoRepository.addTodo(todo) : _todoRepository.updateTodo(todo);
      emit(state.copyWith(status: AddTodoStatus.success));
    } catch(e) {
      emit(state.copyWith(status: AddTodoStatus.failure));
    }
  }
}
