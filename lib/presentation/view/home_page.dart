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


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) =>
    //   TodoBloc(
    //       todoRepositoryImpl: context.read<TodoRepositoryImpl>()
    //   )
    //     ..add(const GetTodoListEvent()),
    //   child: const HomeView(),
    // );

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            TodoBloc(
                todoRepositoryImpl: context.read<TodoRepositoryImpl>()
            )..add(const GetTodoListEvent())
          ),
          BlocProvider(create: (context) =>
              AppBarBloc(
                  todoRepositoryImpl: context.read<TodoRepositoryImpl>()
              )..add(const AppBarTodoStatsRequested())
          ),
        ],
        child: const HomeView(),
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
          create: (dialogContext) => AddTodoBloc(
              todoRepositoryImpl: context.read<TodoRepositoryImpl>(),
          ),
          child: const AddTodoDialog(),
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
                          itemCount: state.filteredAndOrderedTodos.length,
                          itemBuilder: (context, index) {
                            var todo = state.filteredAndOrderedTodos.elementAt(index);

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

