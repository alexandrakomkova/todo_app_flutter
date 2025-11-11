import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';
import 'package:todo_app/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:todo_app/presentation/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_app/presentation/widget/add_todo_dialog.dart';
import 'package:todo_app/presentation/widget/todo_card.dart';

import '../domain/model/todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      TodoBloc(
          todoRepositoryImpl: context.read<TodoRepositoryImpl>()
      )
        ..add(const GetTodoListEvent()),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
        context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
          create: (context) => AddTodoBloc(
              todoRepositoryImpl: context.read<TodoRepositoryImpl>(),
            initialTodo: null
          ),
          child: const AddTodoDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: Icon(
            Icons.add
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.todoList.isEmpty) {
              if (state.status == TodoStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != TodoStatus.success) {
                return const SizedBox();
              } else {
                return _emptyTodoList();
              }
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ListView.builder(
                          itemCount: state.todoList.length,
                          itemBuilder: (context, index) {
                            var todo = state.todoList[index];

                            return TodoCard(todo: todo);
                          },
                        )
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

Widget _emptyTodoList() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '''Click "+" to add your first task!''',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
}

