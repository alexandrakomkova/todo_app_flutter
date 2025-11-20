import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/theme/theme.dart';

import '/domain/model/todo.dart';
import '/presentation/bloc/todo_bloc/todo_bloc.dart';


class TodoCard extends StatelessWidget {
  final Todo todo;
  final void Function() showEditTodoDialog;

 const TodoCard({
    required this.todo,
    required this.showEditTodoDialog,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Gradient? doneGradient = Theme.of(context).brightness == Brightness.light
        ? TodoTheme.backgroundTodoCardCompletedLight
        : TodoTheme.backgroundTodoCardCompletedDark;

    Gradient? notDoneGradient = Theme.of(context).brightness == Brightness.light
        ? TodoTheme.backgroundTodoCardUnCompletedLight
        : TodoTheme.backgroundTodoCardUnCompletedDark;

    return Container(
      decoration: BoxDecoration(
        gradient: todo.isCompleted ? doneGradient : notDoneGradient,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(4.0),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            context.read<TodoBloc>().add(OnCompletedChanged(todo: todo, isCompleted: !todo.isCompleted));
          },
          splashColor: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black.withValues(alpha: 0.15)
            ),
            padding: EdgeInsets.all(8.0),
            child: todo.isCompleted ? Icon(Icons.done) : Icon(Icons.clear_rounded),
          ),
        ),
        title: Text(
            todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                todo.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              todo.formattedCreationTimestamp,
              style: TextStyle(
                  fontSize: 12
              ),
            ),
          ],
        ),
        trailing: InkWell(
          onTap: () {
            context.read<TodoBloc>().add(DeleteTodoEvent(todo));
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black.withValues(alpha: 0.15)
            ),
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete
            ),
          ),
        ),
        onTap: () => showEditTodoDialog(),
      ),
    );
  }
}