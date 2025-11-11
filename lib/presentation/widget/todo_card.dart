import 'package:flutter/material.dart';

import '../../domain/model/todo.dart';


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
        trailing: Icon(
            Icons.delete
        ),
      ),
    );
  }
}