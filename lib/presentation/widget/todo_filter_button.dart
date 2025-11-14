import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/l10n/l10n.dart';
import 'package:todo_app/presentation/bloc/todo_bloc/todo_bloc.dart';

import '../../domain/model/todo_filter/todo_filter.dart';

class TodoFilterButton extends StatelessWidget {
  const TodoFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final activeFilter = context.select(
        (TodoBloc bloc) => bloc.state.filter,
    );

    return PopupMenuButton<TodoFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),
        initialValue: activeFilter,
        onSelected: (filter) {
          context.read<TodoBloc>().add(
            OnFilterChanged(filter),
          );
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: TodoFilter.all,
              child: Text(l10n.appBarFilterAll),
            ),
            PopupMenuItem(
                value: TodoFilter.completedOnly,
                child: Text(l10n.appBarFilterCompletedOnly),
            ),
            PopupMenuItem(
              value: TodoFilter.unCompletedOnly,
              child: Text(l10n.appBarFilterUncompletedOnly),
            ),
          ];
        },
      icon: const Icon(Icons.filter_alt_rounded),
    );
  }
}
