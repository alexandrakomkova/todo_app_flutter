import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '/domain/model/todo.dart';
import '/domain/repository/todo_repository.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoBlocEvent, AddTodoState> {
  final TodoRepository _todoRepository;
  final Todo? initialTodo;

  AddTodoBloc({
    required TodoRepository todoRepository,
    this.initialTodo,
  }) : _todoRepository = todoRepository,
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
      }
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

    try {
      if(state.isNewTodo) {
        await _todoRepository.addTodo(
          Todo(
            title: state.title,
            description: state.description,
            creationTimestamp: DateTime.now().millisecondsSinceEpoch,
          )
        );
      } else {
        await _todoRepository.updateTodo(
          Todo(
            title: state.title,
            description: state.description,
            creationTimestamp: int.parse(state.id) ,
          )
        );
      }
      emit(state.copyWith(status: AddTodoStatus.success));
    } catch(e) {
      emit(state.copyWith(status: AddTodoStatus.failure));
    }
  }
}
