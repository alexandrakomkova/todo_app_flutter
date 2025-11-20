import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:todo_app/presentation/view/home_page.dart';

import '/data/repository/todo_repository_impl.dart';
import '/domain/model/todo.dart';
import '/l10n/app_localizations.dart';
import '/presentation/theme/theme.dart';

class App extends StatelessWidget {
  final Box<Todo> todoBox;

  const App({
    required this.todoBox,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodoRepositoryImpl>(
      create: (_) => TodoRepositoryImpl(todoBox),
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
        theme: TodoTheme.light,
        darkTheme: TodoTheme.dark,
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: [
          Locale('en'),
          Locale('ru'),
        ],
        home: HomePage()
    );
  }
}

