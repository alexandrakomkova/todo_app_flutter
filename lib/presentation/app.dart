import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/home_page.dart';

import '../data/repository/todo_repository_impl.dart';

class App extends StatelessWidget {
  final TodoRepositoryImpl Function() createTodoRepositoryImpl;

  const App({
    required this.createTodoRepositoryImpl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodoRepositoryImpl>(
      create: (_) => createTodoRepositoryImpl(),
      dispose: (repository) => repository.close(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage()
    );
  }
}

