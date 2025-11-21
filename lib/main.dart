import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:todo_app/app/app.dart';
import 'package:todo_app/app/app_bloc_observer.dart';
import 'package:todo_app/data/data_source/hive_todo_adapter.dart';
import 'package:todo_app/domain/model/todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  final todoBox = await Hive.openBox<Todo>('todos');

  Bloc.observer = const AppBlocObserver();

  runApp(
      App(todoBox: todoBox,)
  );
}
