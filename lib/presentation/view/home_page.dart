
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';
import 'package:todo_app/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:todo_app/presentation/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:todo_app/presentation/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_app/presentation/widget/add_todo_dialog.dart';
import 'package:todo_app/presentation/widget/todo_card.dart';
import 'package:todo_app/presentation/widget/todo_filter_button.dart';
import 'package:todo_app/presentation/widget/todo_sort_button.dart';

import '/domain/model/todo.dart';
import '/presentation/widget/empty_todo_list.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(
            create: (todoBlocContext) =>
            TodoBloc.getList(
                todoRepository: todoBlocContext.read<TodoRepositoryImpl>()
            )
          ),
          BlocProvider<AppBarBloc>(
              create: (appBarBlocContext) =>
              AppBarBloc.requestStats(
                  todoRepository: appBarBlocContext.read<TodoRepositoryImpl>()
              )
          ),
        ],
        child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({super.key});

  void _showAddTodoDialog(BuildContext context, [Todo? todo]) {
    showDialog(
        context: context,
      builder: (_) {
        return BlocProvider(
          create: (_) => AddTodoBloc(
            todoRepository: context.read<TodoRepositoryImpl>(),
            initialTodo: todo
          ),
          child: AddTodoDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AppBarBloc, AppBarState>(
            builder: (context, state) {
              return Text('✅ ${state.completedTodoCount}   ❌ ${state.unCompletedTodoCount}');
            }
        ),
        actions: const [
          TodoFilterButton(),
          TodoSortButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 0.0,
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
                return EmptyTodoList();
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
                          itemCount: state.filteredAndOrderedTodos.length,
                          itemBuilder: (context, index) {
                            var todo = state.filteredAndOrderedTodos.elementAt(index);

                            return TodoCard(
                              todo: todo,
                              showEditTodoDialog: () {
                                _showAddTodoDialog(context, todo);
                              },
                            );
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