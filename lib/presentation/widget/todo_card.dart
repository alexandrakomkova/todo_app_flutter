import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/todo.dart';
import '../bloc/todo_bloc/todo_bloc.dart';


class TodoCard extends StatelessWidget {
  final Todo todo;

 const TodoCard({
    required this.todo,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Gradient? doneGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.green.shade200, Colors.blue.shade200],
    );

    Gradient? notDoneGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.red.shade200, Colors.purple.shade200],
    );

    return Container(
      decoration: BoxDecoration(
        gradient: todo.isCompleted ? doneGradient : notDoneGradient,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(4.0),
      child: ListTile(
        leading: todo.isCompleted ? Icon(Icons.done) : Icon(Icons.clear_rounded),
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
              todo.formattedDate,
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
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete
            ),
          ),
        ),
      ),
    );
  }
}