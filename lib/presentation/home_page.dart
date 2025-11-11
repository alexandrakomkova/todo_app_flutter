import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';
import 'package:todo_app/presentation/bloc/todo_bloc/todo_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TodoBloc(
            todoRepositoryImpl: context.read<TodoRepositoryImpl>()
        )..add(const GetTodoListEvent()),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

