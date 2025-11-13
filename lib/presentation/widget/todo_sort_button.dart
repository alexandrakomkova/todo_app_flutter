import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/bloc/todo_bloc/todo_bloc.dart';

import '../../domain/model/todo_order/todo_order.dart';

class TodoSortButton extends StatelessWidget {
  const TodoSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeOrderType = context.select(
          (TodoBloc bloc) => bloc.state.orderType,
    );

    return PopupMenuButton<TodoOrderType>(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),
      initialValue: activeOrderType,
      onSelected: (orderType) {
        context.read<TodoBloc>().add(
          OnOrderTypeChanged(orderType),
        );
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodoOrderType.ascending,
            child: Text('Newer first'),
          ),
          PopupMenuItem(
            value: TodoOrderType.descending,
            child: Text('Older first'),
          ),
        ];
      },
      icon: const Icon(Icons.sort_rounded),
    );
  }
}
