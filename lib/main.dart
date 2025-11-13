import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:todo_app/app/app.dart';

import 'app/app_bloc_observer.dart';
import 'data/data_source/hive_todo_adapter.dart';
import 'data/repository/todo_repository_impl.dart';
import 'di/injection.dart';
import 'domain/model/todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  configureInjection();

  final box = await Hive.openBox<Todo>('todos');
  print('box length: ${box.length}');

  Bloc.observer = const AppBlocObserver();

  runApp(
      App(createTodoRepositoryImpl: () => TodoRepositoryImpl(box))
  );
}
